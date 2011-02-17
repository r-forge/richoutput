makeAmeliaDialog <- function() {
		AmeliaDialog <- new(SimpleRDialog)
		AmeliaDialog$setSize(520L,600L)
		AmeliaDialog$setTitle("Impute Missing Data")
	
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(AmeliaDialog,variableSelector, 10, 420, 820, 10)
		
		#add text field to enter name of new dataset
		JLabel <- J("javax.swing.JLabel")
		nameLabel <- new(JLabel,"Title for new dataset:")
		nameText <- new(TextFieldWidget)
		nameText$setTitle("label")
		addComponent(AmeliaDialog, nameLabel, 30, 700, 70, 490)
		addComponent(AmeliaDialog, nameText, 30, 990, 70, 710)

		#add a list for the regularly-scored variables
		varList<- new(VariableListWidget,"Variables for imputation",variableSelector)
		varList$setTitle("variables")
		addComponent(AmeliaDialog, varList, 80, 990, 350, 490)
		
		#add additional variables
		subjList<- new(VariableListWidget,"Other variables to keep",variableSelector)
		subjList$setTitle("idvars")
		addComponent(AmeliaDialog, subjList, 360, 990, 680, 490)
	
		#setting Run and Check functions
		AmeliaDialog$setCheckFunction(toJava(.AmeliaCheckFunction))
		AmeliaDialog$setRunFunction(toJava(.AmeliaRunFunction))
		
		return(AmeliaDialog)
	}
