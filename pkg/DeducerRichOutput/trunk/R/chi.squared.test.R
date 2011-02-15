chi.squared.test <- function (x, y = NULL, conservative = FALSE, cramers.v.conf = 0.95, 
    simulate.p.value = FALSE, B = 10000) 
{
    cramers.v <- function(chival, df, n, k, conf) {
        non.cent <- chi.noncentral.conf(chival, df, conf)
        V <- sqrt(chival/(n * (k - 1)))
        low <- sqrt(non.cent[1, 1]/(n * (k - 1)))
        hi <- sqrt(non.cent[2, 1]/(n * (k - 1)))
        hi <- min(hi, 1)
        result <- c(V, low, hi)
        names(result) <- c("Cramer's V", (1 - conf)/2, 1 - (1 - 
            conf)/2)
        result
    }
    ESTIMATE <- NA
    CONF.INT <- c(NA, NA)
    DNAME <- deparse(substitute(x))
    if (is.data.frame(x)) 
        x <- as.matrix(x)
    if (is.matrix(x)) {
        if (min(dim(x)) == 1) 
            x <- as.vector(x)
    }
    if (!is.matrix(x) && !is.null(y)) {
        if (length(x) != length(y)) 
            stop("'x' and 'y' must have the same length")
        DNAME <- c(DNAME, deparse(substitute(y)))
        OK <- complete.cases(x, y)
        x <- factor(x[OK])
        y <- factor(y[OK])
        if ((nlevels(x) < 2) || (nlevels(y) < 2)) 
            stop("'x' and 'y' must have at least 2 levels")
        x <- table(x, y)
        names(dimnames(x)) <- DNAME
        DNAME <- paste(DNAME, collapse = " and ")
    }
    if (any(x < 0) || any(is.na(x))) 
        stop("all entries of 'x' must be nonnegative and finite")
    if ((n <- sum(x)) == 0) 
        stop("at least one entry of 'x' must be positive")
    if (simulate.p.value) {
        setMETH <- function() METHOD <<- paste(METHOD, "with simulated", 
            if (conservative) 
                "(mid)"
            else "(conservative)", "p-value\n\t (based on", B, 
            "replicates)")
        almost.1 <- 1 - 64 * .Machine$double.eps
        just.over.1 <- 1 + 64 * .Machine$double.eps
    }
    if (is.matrix(x)) {
        METHOD <- "Pearson's Chi-squared test"
        nr <- nrow(x)
        nc <- ncol(x)
        sr <- rowSums(x)
        sc <- colSums(x)
        E <- outer(sr, sc, "*")/n
        dimnames(E) <- dimnames(x)
        if (simulate.p.value && all(sr > 0) && all(sc > 0)) {
            setMETH()
            tmp <- .C("chisqsim", as.integer(nr), as.integer(nc), 
                as.integer(sr), as.integer(sc), as.integer(n), 
                as.integer(B), as.double(E), integer(nr * nc), 
                double(n + 1), integer(nc), results = double(B), 
                PACKAGE = "stats")
            STATISTIC <- sum(sort((x - E)^2/E, decreasing = TRUE))
            PARAMETER <- (nr - 1) * (nc - 1)
            PVAL <- (1 + sum(tmp$results >= almost.1 * STATISTIC))/(B + 
                1)
            if (!conservative) 
                PVAL <- PVAL - 0.5 * (sum((tmp$results <= just.over.1 * 
                  STATISTIC) & (tmp$results >= almost.1 * STATISTIC))/(B + 
                  1))
        }
        else {
            if (simulate.p.value) 
                warning("cannot compute simulated p-value with zero marginals")
            if (conservative && nrow(x) == 2 && ncol(x) == 2) {
                YATES <- 0.5
                METHOD <- paste(METHOD, "with Yates' continuity correction")
            }
            else if (conservative && !(nrow(x) == 2 && ncol(x) == 
                2)) {
                warning("Conservative Yates correction only applies to 2X2 tables.")
                return(structure(list(estimate = NA, conf.int = NA, 
                  statistic = NA, parameter = NA, p.value = NA, 
                  method = paste(METHOD, "with Yates' continuity correction"), 
                  data.name = DNAME, observed = x, expected = E, 
                  residuals = (x - E)/sqrt(E)), class = "htest"))
            }
            else YATES <- 0
            STATISTIC <- sum((abs(x - E) - YATES)^2/E)
            PARAMETER <- (nr - 1) * (nc - 1)
            PVAL <- pchisq(STATISTIC, PARAMETER, lower.tail = FALSE)
            if (!conservative) {
                cramer <- cramers.v(STATISTIC, PARAMETER, n, 
                  min(nr, nc), cramers.v.conf)
                ESTIMATE <- cramer[1]
                CONF.INT <- cramer[2:3]
                attr(CONF.INT, "conf.level") <- cramers.v.conf
            }
        }
    }
    else {
        stop("Could not create table from x and y")
    }
    names(STATISTIC) <- "X-squared"
    names(PARAMETER) <- "df"
# begin addition
	if (any(E < 5) && !simulate.p.value) {
        warning(paste(length(E[E < 5]),"cell(s) with expected value less than 5.",
			"Chi-squared approximation may be incorrect.",
			"Consider using the Monte Carlo Simulation option."))
	}
# end addition
    structure(list(estimate = ESTIMATE, conf.int = CONF.INT, 
        statistic = STATISTIC, parameter = PARAMETER, p.value = PVAL, 
        method = METHOD, data.name = DNAME, observed = x, expected = E, 
        residuals = (x - E)/sqrt(E)), class = "htest")
}
