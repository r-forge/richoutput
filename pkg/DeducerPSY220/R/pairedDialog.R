makePairedDialog <- function() {
		pairedDialog <- new(SimpleRDialog)
		pairedDialog$setSize(520L,600L)
		pairedDialog$setTitle("Paired Sample t-test")
	
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(pairedDialog,variableSelector, 10, 420, 820, 10)
		
		#add a list for first variable
		firstList<- new(SingleVariableWidget,"First Variable",variableSelector)
		firstList$setTitle("first")
		addComponent(pairedDialog, firstList, 30, 990, 130, 490)
		
		#add a list for second variable
		secondList<- new(SingleVariableWidget,"Second Variable",variableSelector)
		secondList$setTitle("second")
		addComponent(pairedDialog, secondList, 140, 990, 240, 490)

				#setting Run and Check functions
		pairedDialog$setCheckFunction(toJava(.pairedCheckFunction))
		pairedDialog$setRunFunction(toJava(.pairedRunFunction))
		
		return(pairedDialog)
	}
