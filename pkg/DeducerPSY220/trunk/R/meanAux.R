# meanDialog auxiliary functions
# by Bill Altermatt

	.meanCheckFunction <- function(state){		
		#make sure at least two variables are selected
		if(length(state$variables) + length(state$reversed) < 2)
			return("Please select at least 2 variables")
		#make sure max value is specified if reverse-scoring
		if(!is.null(state$reversed) && (state$max == ""))
			return("Please enter maximum possible value for reverse-scored variables")
		#make sure label for new mean is entered
		if(state$label == "")
			return("Please enter label for new mean")
		return("")
		}
	
	
	.meanRunFunction <- function(state){
		variables = paste(state$variables,collapse=", ")
		reversed = paste(state$reversed,collapse=", ")
		if (!is.null(state$reversed)) 
			revLabels = paste(state$reversed,".rev",collapse=", ",sep="")
		else revLabels = NULL
		bothLabels = paste(variables,revLabels,sep=", ")
		cmd = paste(state$data,"[['",state$label,"']] <- newMean(data = ",state$data,",\n", 
			if(!is.null(state$variables)) paste(" variables = d(",variables,"),\n"),
			if(!is.null(state$reversed)) paste(" reversed = d(",reversed, "),\n"),
			if(!state$max == "") paste(" max = ", state$max, ",\n", sep = ""),
			" label = \"",state$label,"\")\n",sep="")
		cmd = paste(cmd,"attr(",state$data,"[['",state$label,"']], ","\"mean of these items\") = \"",
			bothLabels,"\"\n",sep="")
		if(any(grepl("Save", state$Options))) {
			cmd = paste(cmd, state$data, "<- cbind(", state$data,", ", 
				"revData(data = ",state$data,", variables = d(", variables, "), ",
				"reversed = d(", reversed, "), max = ", state$max, ")$reversed)",sep="")			
			}
		if(any(grepl("reliability", state$Options))) {	
			cmd = paste(cmd, "cat(alpha.item(revData(data = ",state$data,", variables = d(", variables, "), ",
				"reversed = d(", reversed, "), max = ", state$max, ")$data))",sep="")
			}
		execute(cmd)	
	}


	getMeanDialog <- function(){
		if(!exists(".meanDialog")){
			#make meanDialog
			.meanDialog <- makeMeanDialog()
			assign(".meanDialog",.meanDialog,globalenv())		
		}
		return(.meanDialog)
	}

	
	
