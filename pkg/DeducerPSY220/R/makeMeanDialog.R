makeMeanDialog <- function() {
		meanDialog <- new(SimpleRDialog)
		meanDialog$setSize(520L,600L)
		meanDialog$setTitle("Compute mean")
	
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(meanDialog,variableSelector, 10, 420, 820, 10)
		
		#add text field to enter name of new mean variable
		JLabel <- J("javax.swing.JLabel")
		nameLabel <- new(JLabel,"Label for new mean:")
		nameText <- new(TextFieldWidget)
		nameText$setTitle("label")
		addComponent(meanDialog, nameLabel, 30, 700, 70, 490)
		addComponent(meanDialog, nameText, 30, 990, 70, 710)
		
		#add a list for the regularly-scored variables
		varList<- new(VariableListWidget,"Variables",variableSelector)
		varList$setTitle("variables")
		addComponent(meanDialog, varList, 80, 990, 385, 490)

		#add a list for variables to be reversed
		reversedList<- new(VariableListWidget,"Reverse-scored Variables",variableSelector)
		reversedList$setTitle("reversed")
		addComponent(meanDialog, reversedList, 395, 990, 720, 490)

		#add text field to enter max value
		JLabel <- J("javax.swing.JLabel")
		maxLabel <- new(JLabel,"Max response value:")
		maxValue <- new(TextFieldWidget)
		maxValue$setTitle("max")
		addComponent(meanDialog, maxLabel, 730, 700, 770, 490)
		addComponent(meanDialog, maxValue, 730, 990, 770, 710)
				
		#add option to save reversed variables
		saveReversed <- new(CheckBoxesWidget,c("Save reverse-scored variables","Print reliability"))
		saveReversed$setTitle("Options")
		addComponent(meanDialog, saveReversed, 780, 990, 880, 650)

		#setting Run and Check functions
		meanDialog$setCheckFunction(toJava(.meanCheckFunction))
		meanDialog$setRunFunction(toJava(.meanRunFunction))
		
		return(meanDialog)
	}
