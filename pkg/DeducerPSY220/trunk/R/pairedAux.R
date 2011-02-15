# pairedDialog auxiliary functions
# by Bill Altermatt

	.pairedCheckFunction <- function(state){		
		#make sure two variables are selected
		if(is.null(state$first) || is.null(state$second))
			return("Please select first and second variables")
		return("")
		}
	
	
	.pairedRunFunction <- function(state){
		cmd = paste("descriptive.table(vars = d(",state$first,",",state$second, 
			"),data = ",state$data, 
			",\nfunc.names =c(\"Mean\",\"St. Deviation\",\"Valid N\"))\n", sep="")
		cmd = paste(cmd,"pairedT(data = ",state$data,", first = ",state$first,
			", second = ",state$second,")\n",sep="")
		execute(cmd)
	}


	getPairedDialog <- function(){
		if(!exists(".pairedDialog")){
			#make pairedDialog
			.pairedDialog <- makePairedDialog()
			assign(".pairedDialog",.pairedDialog,globalenv())		
		}
		return(.pairedDialog)
	}

	
	
