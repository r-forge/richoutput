# Implementation of some package 'ez' functions for Deducer
# by Bill Altermatt

DeducerEZ <- function(data, dv, wid, between = NULL, observed = NULL, 
	within = NULL, type = 3, detailed = FALSE, descriptives = FALSE, 
	x = NULL, split = NULL, x_lab = NULL, y_lab = NULL, split_lab = NULL, newID = FALSE) 
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
#	if (!is.null(attr(results,"warnings")))	attr(to_return,"warnings") <- attr(results,"warnings")

	if(descriptives) {
		to_return$'Descriptive Statistics' <- withConditions(ezStats( 
			    data = data
			    , dv = dv
			    , wid = wid
			    , within = within
			    , between = between # or could be a subset of between
			    , between_full = between
			    , diff = NULL
			    , reverse_diff = FALSE
				)
			)
		}
		
	class(to_return) = "ez"
	
	print(to_return)

	ti = paste("[ANOVA] ",as.character(dv), " ~ ", if(!is.null(between)) paste("btw(",paste(as.character(between),collapse="*"),")",sep=""), 
		if(!is.null(within)) paste("w/in(",paste(as.character(within),collapse="*"),")",sep=""),sep="")
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)

# plot
	# If any rows were cut, pass the row numbers along to ggplot in 'excluded'
		if(!is.null(attr(data,"na.action"))) excluded = paste(attr(data,"na.action"),collapse=",") else excluded = NULL
	# Is the x-axis variable a within-subjects variable?  If yes, ggplot will connect the points with a line.
		xwithin = FALSE
		if(!is.null(within)) if(as.character(x) %in% as.character(within)) xwithin = TRUE
	if(!is.null(x)) {
		gg2way(data = data.name, exclude = excluded, x = as.character(x), y = as.character(dv), xwithin = xwithin, split = as.character(split), 
			x_lab = x_lab, y_lab = y_lab, split_lab = split_lab)
		#ti = paste("[plot] ",as.character(dv), " ~ ", as.character(x), if(!is.null(split)) paste(" by ",as.character(split),sep=""),sep="")
#		elem <- record$getActiveElement()
#		elem$setTitle(ti)
	}

# Tukey Post Hoc tests for between-subjects factors

			

	
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
			return("Please specify a subject ID variable or check the sQuote(Use rownames) box")
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

	
	
