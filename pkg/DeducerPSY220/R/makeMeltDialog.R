makeMeltDialog <- function() {
		meltDialog <- new(SimpleRDialog)
		meltDialog$setSize(520L,600L)
		meltDialog$setTitle("Reshape Data")
		
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(meltDialog,variableSelector, 10, 420, 820, 10)
		
		#add text field to enter name of melted data
		JLabel <- J("javax.swing.JLabel")
		nameLabel <- new(JLabel,"Name of new dataset:")
		nameText <- new(TextFieldWidget)
		nameText$setTitle("newDataName")
		addComponent(meltDialog, nameLabel, 30, 700, 70, 490)
		addComponent(meltDialog, nameText, 30, 990, 70, 710)

		#add a list for id variables
		idList<- new(VariableListWidget,"ID variables",variableSelector)
		idList$setTitle("id.vars")
		addComponent(meltDialog, idList, 80, 990, 310, 490)

		#add a list for the measured variables
		measuredList<- new(VariableListWidget,"Measured variables",variableSelector)
		measuredList$setTitle("measure.vars")
		addComponent(meltDialog, measuredList, 320, 990, 550, 490)

		#add text field to enter name of variable to store original variable names
		JLabel <- J("javax.swing.JLabel")
		nameLabel <- new(JLabel,"Name for measured variables:")
		nameText <- new(TextFieldWidget)
		nameText$setTitle("variable_name")
		addComponent(meltDialog, nameLabel, 560, 780, 600, 490)
		addComponent(meltDialog, nameText, 560, 990, 600, 790)

		bg <- new(ButtonGroupWidget,c("Remove NA values","Keep NA values"))
		bg$setTitle("Options")
		bg$setDefaultModel("Remove NA values")
		addComponent(meltDialog, bg, 610, 990, 810, 490)
			
		#setting Run and Check functions
		meltDialog$setCheckFunction(toJava(.meltCheckFunction))
		meltDialog$setRunFunction(toJava(.meltRunFunction))
		
		return(meltDialog)
	}
