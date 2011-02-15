# ez ANOVA auxiliary functions
# by Bill Altermatt

	.ezAnalysisCheckFunction <- function(state){		
		#make sure at least one dv and one factor are selected
		if(is.null(state$dv))
			return("Please select a dependent variable")
#		make sure max value is specified if reverse-scoring
		if(is.null(state$between) && is.null(state$within))
			return("Please select at least one between-subjects or within-subjects factor")
#		make sure subject ID is specified
		if(is.null(state$wid))
			return("Please specify a subject ID variable")
		return("")
		}
	
	
	.ezAnalysisRunFunction <- function(state){
#		print(state) #a print statement is useful for debugging
		state <<- state
		data = eval(parse(text=state$data))
		between = observed = within = NULL
		dv = eval(parse(text=paste(".(",state$dv,")",sep="")))
		if(!is.null(state$between)) between = eval(parse(text=paste(".(",paste(state$between,sep="",collapse=","),")",sep="")))
		if(!is.null(state$observed)) observed = eval(parse(text=paste(".(",paste(state$observed,sep="",collapse=","),")",sep="")))		
		wid = eval(parse(text=paste(".(",state$wid,")",sep="")))
		if(!is.null(state$within)) within = eval(parse(text=paste(".(",paste(state$within,sep="",collapse=","),")",sep="")))
		detailed = FALSE
		if(any(grepl("Detailed", state$Options))) {
			detailed = TRUE
			}
	# Begin output code
		code = "</pre>"
		# Main title
			code=paste(code,"<h1>Analysis of Variance</h1>",sep="")
		
		# Details of the model
			code = paste(code,"<h3>Model Details</h3>",sep="")
			code = paste(code,"<table><tr><th align=\"right\">Data: </th><td align=\"left\">",state$data,"</td></tr>",sep="")
			code = paste(code,"<tr><th align=\"right\">Dependent variable: </th><td align=\"left\">",state$dv,"</td></tr>",sep="")
			code = paste(code,"<tr><th align=\"right\">Between-subjects factor(s): </th><td align=\"left\">",paste(state$between,collapse=", "),"</td></tr>",sep="")
			code = paste(code,"<tr><th align=\"right\">Observed variable(s): </th><td align=\"left\">",paste(state$observed,collapse=", "),"</td></tr>",sep="")
			code = paste(code,"<tr><th align=\"right\">Subject ID: </th><td align=\"left\">",state$wid,"</td></tr>",sep="")
			code = paste(code,"<tr><th align=\"right\">Within-subjects factor(s): </th><td align=\"left\">",paste(state$within,collapse=", "),"</td></tr>",sep="")
			code = paste(code,"</table>")

	# generating main ANOVA results
		results <- ezANOVA(
			data = data
			, dv = dv
			, wid = wid
			, within = within
			, between = between
			, observed = observed
			, diff = NULL
			, reverse_diff = FALSE
			, detailed = detailed
			)
		for(i in 1:length(results)) {
			code = paste(code,"<h3>",names(results[i]),"</h3>",sep="")
			code = paste(code,h.df(results[[i]], rowcolors = TRUE),sep="")
			}
	# plot
		if(any(grepl("Plot", state$Options))) {
			
			}
	# Non-parametric permutation test
		if(any(grepl("permutation", state$Options))) {
			permutation <- ezPerm(
			    data = data
			    , dv = dv
			    , wid = wid
			    , within = within
			    , between = between
			    , perms = as.integer(state$perms)
			    , alarm = TRUE
			)
			for(i in 1:length(permutation)) {
				code = paste(code,"<h3>",names(permutation[i]),"</h3>",sep="")
				code = paste(code,h.df(permutation[[i]], rowcolors = TRUE),sep="")
				}
		}
	# Descriptive statistics
		if(any(grepl("Descriptive", state$Options))) {
			descriptives <- ezStats( # output is a data.frame
			    data = data
			    , dv = dv
			    , wid = wid
			    , within = within
			    , between = between # or could be a subset of between
			    , between_full = between
			    , diff = NULL
			    , reverse_diff = FALSE
				)
			code = paste(code,"<h3>Descriptive Statistics</h3>",sep="")			
			code = paste(code,h.df(descriptives, rowcolors = TRUE),sep="")	
		}
	code = paste(code,"<pre>",sep="")
	cat(code)
	ti = paste("[ANOVA] ",state$dv, " ~ ", if(!is.null(state$between)) paste("btw(",paste(state$between,collapse="*"),")",sep=""), 
		if(!is.null(state$within)) paste("w/in(",paste(state$within,collapse="*"),")",sep=""),sep="")
	record <- J("RichOutput.OutputController")$record
	elem <- record$getActiveElement()
	elem$setTitle(ti)		
	}


	getEZAnalysisDialog <- function(){
		if(!exists(".ezDialog")){
			#make ez ANOVA analysis dialog
			.ezDialog <- makeEZDialog()
			assign(".ezDialog",.ezDialog,globalenv())		
		}
		return(.ezDialog)
	}

	
	
