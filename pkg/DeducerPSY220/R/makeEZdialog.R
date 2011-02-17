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
		addComponent(ezDialog,button,830,180,880,10)
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
			"Non-parametric permutation test", 
			"Descriptive statistics"))		
			#add text field to enter number of permutations
				JLabel <- J("javax.swing.JLabel")
				permLabel <- new(JLabel,"Number of permutations (>1000 rec'd):")
				permValue <- new(TextFieldWidget)
				permValue$setTitle("perms")
				addComponent(subEZ, permLabel, 710, 800, 810, 50)
				addComponent(subEZ, permValue, 710, 900, 810, 610)			
		addComponent(subEZ, optionEZ, 10, 990, 700, 10)

		#Add a 'Plot' button
		JButton <- J("javax.swing.JButton")
		plotButton <- new(JButton,"Plot")
		addComponent(ezDialog,plotButton,830,360,880,190)
		setSize(plotButton,200L,50L)

		#Listen for the plot button to be pressed
		plotFunction <- function(cmd,ActionEvent){
			plotEZ$setLocationRelativeTo(plotButton)
			plotEZ$run()
		}
		plotListener <- new(ActionListener)
		plotListener$setFunction(toJava(plotFunction))
		plotButton$addActionListener(plotListener)

		#make Plot subDialog
		plotEZ <- new(SimpleRSubDialog,ezDialog,"ANOVA: Plot")
		setSize(plotEZ,520L,400L)
		
			#add variable selector
			plotVariableSelector <- new(VariableSelectorWidget)
			plotVariableSelector$setTitle("plotData")
			addComponent(plotEZ,plotVariableSelector, 10, 420, 820, 10)

			buffer = 10
			listHeight = 150
			textHeight = 60
			textTop = 10
			textLeft = 690
			textRight = 990
			
			#add a list for x-axis factor
			xList<- new(SingleVariableWidget,"Factor for x-axis",plotVariableSelector)
			xList$setTitle("x")
			addComponent(plotEZ, xList, textTop, 990, textTop + listHeight, 490)
			
			#add a list for legend factor
			textTop = textTop + listHeight + buffer
			splitList<- new(SingleVariableWidget,"Factor for legend",plotVariableSelector)
			splitList$setTitle("split")
			addComponent(plotEZ, splitList, textTop, 990, textTop + listHeight, 490)
	
			#add text field to enter new x-axis label
			textTop = textTop + listHeight + buffer
			xLabel <- new(JLabel,"New label for x-axis:")
			xValue <- new(TextFieldWidget)
			xValue$setTitle("x_lab")
			addComponent(plotEZ, xLabel, textTop, textLeft - 10, textTop + textHeight, textLeft - 210)
			addComponent(plotEZ, xValue, textTop, textRight, textTop + textHeight, textLeft)
			
			#add text field to enter new y-axis label
			textTop = textTop + textHeight + buffer; 
			yLabel <- new(JLabel,"New label for y-axis:")
			yValue <- new(TextFieldWidget)
			yValue$setTitle("y_lab")
			addComponent(plotEZ, yLabel, textTop, textLeft - 10, textTop + textHeight, textLeft - 210)
			addComponent(plotEZ, yValue, textTop, textRight, textTop + textHeight, textLeft)
			
			#add text field to enter new legend label
			textTop = textTop + textHeight + buffer; 
			splitLabel <- new(JLabel,"New label for legend:")
			splitValue <- new(TextFieldWidget)
			splitValue$setTitle("split_lab")
			addComponent(plotEZ, splitLabel, textTop, textLeft - 10, textTop + textHeight, textLeft - 210)
			addComponent(plotEZ, splitValue, textTop, textRight, textTop + textHeight, textLeft)

			#add a list for difference score factor
			textTop = textTop + textHeight + buffer; 
			diffList<- new(SingleVariableWidget,"Factor for difference score",plotVariableSelector)
			splitList$setTitle("diff")
			addComponent(plotEZ, diffList, textTop, 990, textTop + listHeight, 490)
			
			#add combo box for reversing difference
			textTop = textTop + listHeight + buffer;
			revDiff <- new(ComboBoxWidget,"Reverse difference?",c("No","Yes"))
			revDiff$setDefaultModel("No")
			revDiff$setTitle("reverse_diff")
			addComponent(plotEZ, revDiff, textTop, 990, textTop + listHeight, 690)

				
		#setting Run and Check functions
		ezDialog$setCheckFunction(toJava(.ezAnalysisCheckFunction))
		ezDialog$setRunFunction(toJava(.ezAnalysisRunFunction))
		
		return(ezDialog)
	}
