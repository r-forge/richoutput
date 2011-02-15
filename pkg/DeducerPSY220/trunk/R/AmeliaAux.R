# AmeliaDialog auxiliary functions
# by Bill Altermatt

	.AmeliaCheckFunction <- function(state){		
		#make sure label for new mean is entered
		if(state$label == "")
			return("Please enter label for new dataset")
		#check to make sure all variables are numeric
#		if(any(!is.numeric(eval(substitute(variables), data, parent.frame()))))
#			return("Variables for imputation must be numeric")
		#check to make sure max of 4 variables for diagnostics
		if(length(state$diagnosticVars) > 4)
			return("Maximum of 4 variables for diagnostic plots")
		return("")
		}
	
	
	.AmeliaRunFunction <- function(state){
		variables = paste(state$variables,collapse=", ")
		idvars = paste(dQuote(state$idvars),collapse=", ",sep="")
		diagnostics = paste(state$diagnosticVars,collapse=", ")
		cmd = paste("imputed <- imputeData(data = ",state$data,",\n", 
			paste(" variables = d(",variables,"),\n"),
			if(!is.null(state$idvars)) paste(" idvars = c(",idvars, "),\n",sep=""),
			" label = ",dQuote(state$label),")\n", sep="")
		cmd = paste(cmd, state$label, " <- imputed$data\n",sep="")
		cmd = paste(cmd, "cat(imputed$code)\n",sep="")
		cmd = paste(cmd, "rm(imputed)\n",sep="")
		execute(cmd)	
	}


	getAmeliaDialog <- function(){
		if(!exists(".AmeliaDialog")){
			#make meanDialog
			.AmeliaDialog <- makeAmeliaDialog()
			assign(".AmeliaDialog",.AmeliaDialog,globalenv())		
		}
		return(.AmeliaDialog)
	}

	
	
