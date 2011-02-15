# meltDialog auxiliary functions
# by Bill Altermatt

	.meltCheckFunction <- function(state){		
		if(state$newDataName == "") 
			return("Please enter name for new dataset")
		return("")
		}
	
	.meltRunFunction <- function(state){
		id.vars = paste(dQuote(state$id.vars),collapse=", ")
		measure.vars = paste(dQuote(state$measure.vars),collapse=", ")
		cmd = paste(state$newDataName," <- melt(data = ",state$data,"\n", 
			if(!is.null(state$id.vars)) paste(", id.vars = c(",id.vars,"),\n",sep=""),
			if(!is.null(state$measure.vars)) paste(", measure.vars = c(",measure.vars, "),\n",sep=""),
			if(!is.null(state$variable_name)) paste(", variable_name = \"",state$variable_name,"\"\n",sep=""),
			if(any(grepl("Remove", state$Options))) paste(", na.rm = TRUE\n"),
			")\n",sep="")
		execute(cmd)	
	}

	getMeltDialog <- function(){
		if(!exists(".meltDialog")){
			#make meltDialog
			.meltDialog <- makeMeltDialog()
			assign(".meltDialog",.meltDialog,globalenv())		
		}
		return(.meltDialog)
	}

	
	
