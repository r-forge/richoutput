# Implementation of some package 'ez' functions for Deducer
# by Bill Altermatt

DeducerEZ <- function(data, dv, wid, between = NULL, observed = NULL, 
	within = NULL, type = 3, detailed = FALSE, descriptives = FALSE, 
	x = NULL, split = NULL, x_lab = NULL, y_lab = NULL, split_lab = NULL, 
#	posthoc = FALSE,   Note: Cutting Tukey results b/c don't seem correct.
	test.var = NULL, at.var = NULL, var.equal = FALSE,
	p.adjust.method = "holm") 
	{
	# Setting options to permit Type-3 SS that correspond to SAS and SPSS output:
		options(contrasts=c("contr.sum","contr.poly"))
	# Cutting rows of variables in the model that have NAs
		data.name <- as.character(substitute(data))
		vars <- as.character(c(wid,dv,between,within,observed))
		data <- na.exclude(data[,vars])		
	to_return = list()
	header <- as.data.frame(matrix(nrow=7,ncol=2))
		header[,1] <- c("Data:","Dependent variable:","Subject ID:","Between-subjects factor(s):","Within-subjects factor(s):",
			"Observed variable(s):","SS Type:")
		header[,2] <- c(data.name, as.character(dv), as.character(wid),
			if(is.null(between)) "N/A" else paste(between,collapse=", "), 
			if(is.null(within)) "N/A" else paste(within,collapse=", "),
			if(is.null(observed)) "N/A" else paste(observed,collapse=", "),
			type)
		names(header) <- c("Variable","Value")
		to_return$'Model Details' <- header

	results <- withConditions(ezANOVA(
			data = data
			, dv = dv
			, wid = wid
			, within = within
			, between = between
			, observed = observed
			, diff = NULL
			, reverse_diff = FALSE
			, type = type
			, white.adjust = FALSE
			, detailed = detailed
			, return_aov = FALSE
			))

	to_return <- c(to_return,results)
	if (!is.null(attr(results,"warnings")))	attr(to_return$ANOVA,"warnings") <- attr(results,"warnings")

	if(descriptives) {
		 # code borrowed from ezStats
			temp = idata.frame(cbind(data,ezDV = data[,names(data) == as.character(dv)]))
			descrip <- ddply(temp,structure(as.list(c(between,within)),class = 'quoted')
				,function(x){
					N = length(x$ezDV)
					Mean = mean(x$ezDV)
					SD = sd(x$ezDV)
					return(c(N = N, Mean = Mean, SD = SD))
					}
				)
			to_return$'Descriptive Statistics' <- descrip
			}

# Simple Main Effects
	if(!is.null(test.var) & !is.null(at.var)) {
		is.within <- test.var %in% within
		to_return$'Tests of Simple Main Effects' <- sme(data,dv,test.var,is.within,at.var,var.equal,p.adjust.method)
		}
	
	class(to_return) = "ez"
	
	print(to_return)

# Tukey Post Hoc tests for between-subjects factors
#	if(posthoc) {
#		print(summary(ANOVAposthoc(data,dv,between)))
#		}
#

# plot
	# If any rows were cut, pass the row numbers along to ggplot in 'excluded'
		if(!is.null(attr(data,"na.action"))) excluded = paste(attr(data,"na.action"),collapse=",") else excluded = NULL
	# Is the x-axis variable a within-subjects variable?  If yes, ggplot will connect the points with a line.
		xwithin = FALSE
		if(!is.null(within)) if(as.character(x) %in% as.character(within)) xwithin = TRUE
	if(!is.null(x)) {
		gg2way(data = data.name, exclude = excluded, x = as.character(x), y = as.character(dv), xwithin = xwithin, split = as.character(split), 
			x_lab = x_lab, y_lab = y_lab, split_lab = split_lab)
		}
	}


	.ezAnalysisCheckFunction <- function(state){		
		#make sure at least one dv and one factor are selected
		if(is.null(state$dv))
			return("Please select a dependent variable")
#		make sure max value is specified if reverse-scoring
		if(is.null(state$between) && is.null(state$within))
			return("Please select at least one between-subjects or within-subjects factor")
#		make sure subject ID is specified
		if(is.null(state$wid) & is.null(state$newID))
			return("Please specify a subject ID variable or check the \"Use Rownames\" box")
		if(state$SMEdata!=state$data)
			return("Data selected for simple main effects does not match data selected for ANOVA")
		if(state$plotData!=state$data)
			return("Data selected for plot does not match data selected for ANOVA")
		return("")
		}

	getEZAnalysisDialog <- function(){
		if(!exists(".ezDialog")){
			#make ez ANOVA analysis dialog
			.ezDialog <- makeEZDialog()
			assign(".ezDialog",.ezDialog,globalenv())		
		}
		return(.ezDialog)
	}

	
	
