	.ezAnalysisRunFunction <- function(state){
		cmd = paste("DeducerEZ(data = ",state$data,", dv = .(",state$dv,"), wid = .(",sep="")
		if(!is.null(state$wid)) cmd = paste(cmd,state$wid,")\n",sep="") else cmd = paste(cmd,"New.Subject.ID)\n",sep="")
		if(!is.null(state$between)) 
			cmd = paste(cmd,", between = .(",paste(state$between,sep="",collapse=","),")\n",sep="")
		if(!is.null(state$observed)) 
			cmd = paste(cmd,", observed = .(",paste(state$observed,sep="",collapse=","),")\n",sep="")		
		if(!is.null(state$within)) 
			cmd = paste(cmd,", within = .(",paste(state$within,sep="",collapse=","),")\n",sep="")
		if(any(grepl("Type", state$Options))) {
			cmd = paste(cmd,", type=2\n",sep="")
			}
			else {
				cmd = paste(cmd,", type=3\n",sep="")
				}
		if(any(grepl("Detailed", state$Options))) {
			cmd = paste(cmd,", detailed = TRUE\n",sep="")
			}
		if(any(grepl("Descriptive", state$Options))) {	
			cmd = paste(cmd, ", descriptives = TRUE\n",sep="")
			}			
		if(!is.null(state$x)) cmd = paste(cmd, ", x = .(",state$x,")\n",sep="")
		if(!is.null(state$split)) cmd = paste(cmd, ", split = .(",state$split,")\n",sep="")

		if(!is.null(state$x_lab)) cmd = paste(cmd, ", x_lab = \"",state$x_lab,"\"\n",sep="")
		if(!is.null(state$y_lab)) cmd = paste(cmd, ", y_lab = \"",state$y_lab,"\"\n",sep="")
		if(!is.null(state$split_lab)) cmd = paste(cmd, ", split_lab = \"",state$split_lab,"\"\n",sep="")
		if(any(grepl("Tukey", state$Options))) {
			cmd = paste(cmd,", posthoc = TRUE\n",sep="")
			}
		if(!is.null(state$newID)) cmd = paste(cmd, ", newID = TRUE\n",sep="")
		cmd = paste(cmd,")",sep="")
		if(is.null(state$wid)) cmd = paste(state$data,"$New.Subject.ID <- rownames(",state$data,")\n",cmd,sep="")
		execute(cmd)
		}
