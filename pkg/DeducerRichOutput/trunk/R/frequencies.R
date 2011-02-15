frequencies <- function (data, r.digits = 1) 
{
    frequencies.var <- function(variable) {
        freq <- table(variable)
        freq <- as.data.frame(freq)
        freq$Percentage <- round(freq$Freq/sum(freq$Freq) * 100, 
            r.digits)
        freq$Cum.Percentage <- round(cumsum(freq$Freq)/sum(freq$Freq) * 
            100, r.digits)
        num.miss <- matrix(0, nrow = 1, ncol = 4)
        colnames(num.miss) <- c("Valid", "Missing", "Total", "% Missing")
#        row.names(num.miss) <- "# of cases"
        num.miss[1, ] <- c(sum(freq$Freq), sum(is.na(variable)), 
            length(variable), 
			round((sum(is.na(variable))/length(variable)) * 100, r.digits))
        colnames(freq) <- c("Value", "# of Cases", "      %", 
            "Cumulative %")
        result <- list(Frequencies = freq, case.summary = num.miss)
        return(result)
    }
    if (!is.data.frame(data)) {
        data <- as.data.frame(data)
    }
    results <- list()
    for (index in 1:dim(data)[2]) {
#        results[[names(data)[index]]] <- frequencies.var(data[, 
#            index])
        results[[names(data)[index]]] <- withConditions(frequencies.var(data[, 
            index]))
    }
	class(results) = "freq.table"
	return(results)
}
