makeEZDialog <- function() {
		ezDialog <- new(SimpleRDialog)
		ezDialog$setSize(520L,600L)
		ezDialog$setTitle("ANOVA")
		
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(ezDialog,variableSelector, 10, 420, 820, 10)
		
		#add a list for a dependent variable
		dvList<- new(SingleVariableWidget,"Dependent Variable",variableSelector)
		dvList$setTitle("dv")
		addComponent(ezDialog, dvList, 10, 990, 100, 490)

		#add a list for the between-subjects variables
		betweenList<- new(VariableListWidget,"Between-Subjects Factors",variableSelector)
		betweenList$setTitle("between")
		addComponent(ezDialog, betweenList, 110, 990, 310, 490)

		#add a list for the observed (not manipulated) variables
		observedList<- new(VariableListWidget,"Observed (not manipulated) Factors",variableSelector)
		observedList$setTitle("observed")
		addComponent(ezDialog, observedList, 320, 990, 520, 490)

		#add a list for a subject variable
		subjList<- new(SingleVariableWidget,"Subject ID",variableSelector)
		subjList$setTitle("wid")
		addComponent(ezDialog, subjList, 740, 990, 830, 530)

		#add a list for within-subjects variables
		withinList<- new(VariableListWidget,"Within-Subjects Factors",variableSelector)
		withinList$setTitle("within")
		addComponent(ezDialog, withinList, 530, 990, 730, 490)

		#Add an 'Options' button
		JButton <- J("javax.swing.JButton")
		button <- new(JButton,"Options")
		addComponent(ezDialog,button,830,290,880,120)
		setSize(button,200L,50L)
		
		#Listen for the button to be pressed
		ActionListener <- J("org.rosuda.deducer.widgets.event.RActionListener")
		actionFunction <- function(cmd,ActionEvent){
			subEZ$setLocationRelativeTo(button)
			subEZ$run()
		}
		listener <- new(ActionListener)
		listener$setFunction(toJava(actionFunction))
		button$addActionListener(listener)

		#make Options subDialog
		subEZ <- new(SimpleRSubDialog,ezDialog,"ANOVA: Options")
		setSize(subEZ,350,300)
		optionEZ <- new(CheckBoxesWidget,"Options",c("Detailed output (SS, LR, AIC, etc.)", 
			"Plot", "Non-parametric permutation test", 
			"Descriptive statistics"))		
			#add text field to enter number of permutations
				JLabel <- J("javax.swing.JLabel")
				permLabel <- new(JLabel,"Number of permutations (>1000 rec'd):")
				permValue <- new(TextFieldWidget)
				permValue$setTitle("perms")
				addComponent(subEZ, permLabel, 710, 800, 810, 50)
				addComponent(subEZ, permValue, 710, 900, 810, 610)			
		addComponent(subEZ, optionEZ, 10, 990, 700, 10)
				
		#setting Run and Check functions
		ezDialog$setCheckFunction(toJava(.ezAnalysisCheckFunction))
		ezDialog$setRunFunction(toJava(.ezAnalysisRunFunction))
		
		return(ezDialog)
	}
