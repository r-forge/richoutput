# Implementation of some package 'ez' functions for Deducer
# by Bill Altermatt

DeducerANOVA <- function(data, dv, wid, between = NULL, 
	within = NULL, type = 3, detailed = FALSE, descriptives = TRUE, 
	Tukey = TRUE, x = NULL, split = NULL, xwithin = FALSE,
	x_lab = NULL, y_lab = NULL, split_lab = NULL,
	test.var = NULL, at.var = NULL, var.equal = FALSE,
	p.adjust.method = "holm") 
	{
	# Cutting rows of variables in the model that have NAs
		data.name <- as.character(substitute(data))
		vars <- as.character(c(wid,dv,between,within))
		data <- na.exclude(data[,vars])		
	to_return = list()
	results <- withConditions(ezANOVA(
			data = data
			, dv = dv
			, wid = wid
			, within = within
			, between = between
			, type = type
			, detailed = detailed
			, return_aov = Tukey
			))

	to_return <- c(to_return,results)
	if (!is.null(attr(results,"warnings")))	attr(to_return$ANOVA,"warnings") <- attr(results,"warnings")

	if(descriptives) {
			temp = idata.frame(cbind(data,ezDV = data[,names(data) == as.character(dv)]))
			descrip <- ddply(temp,structure(as.list(c(between,within)),class = 'quoted')
				,function(x){
					N = length(x$ezDV)
					Mean = mean(x$ezDV)
					SD = sd(x$ezDV)
					LL = Mean-(qt(0.975,N)*SD/sqrt(N))
					UL = Mean+(qt(0.975,N)*SD/sqrt(N))
					return(c(N = N, Mean = Mean, SD = SD, "95%CI LL" = LL, "95%CI UL" = UL))
					}
				)
			to_return$'Descriptive Statistics' <- descrip
			}

# Simple Main Effects
	if(!is.null(test.var)) {
		is.within <- test.var %in% within
		to_return$'Pairwise Comparisons' <- sme(data,dv,test.var,is.within,at.var,var.equal,p.adjust.method)
		}
	if(Tukey) {
#		y <- data[,match(dv,names(data))]
#		btw <- data[,match(between,names(data))]
#		fmla <- as.formula(paste(as.character(dv),"~", paste(as.character(between), collapse= "*")))
		thsd <- TukeyHSD(results$aov)
		names(thsd) <- paste("TukeyHSD:",names(thsd))
		to_return$'Tukey' <- thsd
		}

	header <- as.data.frame(matrix(nrow=7,ncol=2))
		header[,1] <- c("Data:","Dependent variable:","Subject ID:","Between-subjects factor(s):","Within-subjects factor(s):",
			"SS Type:")
		header[,2] <- c(data.name, as.character(dv), as.character(wid),
			if(is.null(between)) "N/A" else paste(between,collapse=", "), 
			if(is.null(within)) "N/A" else paste(within,collapse=", "),
			type)
		names(header) <- c("Variable","Value")
		to_return$'Model Details' <- header
	
	class(to_return) = "ez"
	


# plot
	# If any rows were cut, pass the row numbers along to ggplot in 'excluded'
		if(!is.null(attr(data,"na.action"))) excluded = paste(attr(data,"na.action"),collapse=",") else excluded = NULL
	if(!is.null(x)) {
		g <- paste("gg2way(data = ",data.name, 
			",exclude = ", excluded, 
			",x = ",as.character(x), 
			",y = ",as.character(dv), 
			",xwithin = ",xwithin, 
			",split = ",as.character(split), 
			",x_lab = ",x_lab, 
			",y_lab = ",y_lab, 
			",split_lab = ",split_lab,")",sep="")
		}
	to_return$'plot' <- g # Adds the plot as an element to the to_return list.
	return(to_return)
	}






	
	
