makeCVDialog <- function() {
		CVDialog <- new(SimpleRDialog)
		CVDialog$setSize(600L,600L)
		CVDialog$setTitle("Combine Variables")
	
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(CVDialog,variableSelector, 10, 380, 820, 10)
		
		#add text field to enter name of new mean variable
		JLabel <- J("javax.swing.JLabel")
		nameLabel <- new(JLabel,"Label for new variable:")
		nameText <- new(TextFieldWidget)
		nameText$setTitle("label")
		addComponent(CVDialog, nameLabel, 30, 700, 70, 460)
		addComponent(CVDialog, nameText, 30, 990, 70, 690)
		
		#add a list for the regularly-scored variables
		varList<- new(VariableListWidget,"Variables",variableSelector)
		varList$setTitle("variables")
		addComponent(CVDialog, varList, 80, 990, 600, 420)

		#how to combine the variables
		combo <- new(ComboBoxWidget,c("Sum","Product","Mean"))
		combo$setDefaultModel("Sum")
		combo$setTitle("Combination")
		addComponent(CVDialog, combo, 710, 990, 760, 500)

		#setting Run and Check functions
		CVDialog$setCheckFunction(toJava(.CVCheckFunction))
		CVDialog$setRunFunction(toJava(.CVRunFunction))
		
		return(CVDialog)
	}

	.CVCheckFunction <- function(state){		
		#make sure at least two variables are selected
		if(length(state$variables) < 2)
			return("Please select at least 2 variables")
		#make sure label for new mean is entered
		if(state$label == "")
			return("Please enter label for new mean")
		if(regexpr("[[:space:]]",state$label) > 0) return("No spaces in label for new mean")
		return("")
		}
	
	.CVRunFunction <- function(state){
		variables = paste(state$variables,collapse="', '")
		cmd = paste(state$data,"[['",state$label,"']] <- apply(",
			state$data,"[match(c('",variables,"'),names(",state$data,"))],1,",
			if(state$Combination=="Sum") paste("sum"),
			if(state$Combination=="Product") paste("prod"),
			if(state$Combination=="Mean") paste("mean"),
			")\n",sep="")
		cmd = paste(cmd,"attr(",state$data,"[['",state$label,"']], ","\"",state$Combination," of these items\") = \"",
			variables,"\"\n",sep="")
		execute(cmd)	
	}


	getCVDialog <- function(){
		if(!exists(".CVDialog")){
			#make CVDialog
			.CVDialog <- makeCVDialog()
			assign(".CVDialog",.CVDialog,globalenv())		
		}
		return(.CVDialog)
	}
	
