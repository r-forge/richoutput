makeEZDialog <- function() {
		ezDialog <- new(SimpleRDialog)
		ezDialog$setSize(550L,600L)
		ezDialog$setTitle("ANOVA")
		
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(ezDialog,variableSelector, 10, 420, 820, 10)

		#add a listener for the Run button in meltDialog, and refresh the data if anything is heard
		if(exists(".meltDialog")) {
			
			}
		
		#add a list for a dependent variable
		dvList<- new(SingleVariableWidget,"Dependent Variable",variableSelector)
		dvList$setTitle("dv")
		addComponent(ezDialog, dvList, 10, 990, 110, 490)

		#add a list for the between-subjects variables
		betweenList<- new(VariableListWidget,"Between-Subjects Factors",variableSelector)
		betweenList$setTitle("between")
		addComponent(ezDialog, betweenList, 120, 990, 310, 490)

		#add a list for the observed (not manipulated) variables
		observedList<- new(VariableListWidget,"Observed Factors",variableSelector)
		observedList$setTitle("observed")
		addComponent(ezDialog, observedList, 320, 990, 520, 490)

		#add a list for a subject variable
		subjList<- new(SingleVariableWidget,"Subject ID",variableSelector)
		subjList$setTitle("wid")
		addComponent(ezDialog, subjList, 740, 990, 840, 490)

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
			setSize(subEZ,350,350)
			optionEZ <- new(CheckBoxesWidget,"Options",c("Type II SS (default is Type III)",
				"Detailed output (SS, LR, AIC, etc.)", 
				"Descriptive statistics"))
#				,"Tukey pairwise comparisons")
			addComponent(subEZ, optionEZ, 10, 990, 700, 10)

		SMEdialog <- new(SimpleRSubDialog,ezDialog,"Simple Main Effects")
			setSize(SMEdialog,670L,400L)
			
			#add variable selector
			varSelector <- new(VariableSelectorWidget)
			varSelector$setTitle("SMEdata")
			addComponent(SMEdialog,varSelector, 10, 420, 820, 10)
			
			#Differences between levels of X
			testList<- new(SingleVariableWidget,"Test differences between levels of:",varSelector)
			testList$setTitle("test.factor")
			addComponent(SMEdialog, testList, 10, 990, 200, 490)	
			
			#At each level of Y
			atList<- new(SingleVariableWidget,"within each level of:",varSelector)
			atList$setTitle("at.factor")
			addComponent(SMEdialog, atList, 210, 990, 400, 490)

			#Method for adjusting p-values
			p.adj <- new(ComboBoxWidget,p.adjust.methods)
				p.adj$setDefaultModel("holm")
				p.adj$setTitle("p-value adjustment method",TRUE)
				addComponent(SMEdialog, p.adj, 410, 990, 580, 500)
				
			#Equal variances assumed?
			eqVar <- new(CheckBoxesWidget,c("Equal variances assumed","box 2"))
			eqVar$setTitle("var.equal")
			eqVar$removeButton(1L)
			addComponent(SMEdialog, eqVar, 590, 990, 760, 500)
		
			SMEb <- new(JButton,"Simple Main Effects")
					SMEfunction <- function(cmd,ActionEvent) {
						SMEdialog$setLocationRelativeTo(SMEb)
						vrd <- varSelector$getModel()
						vd <- variableSelector$getModel()
						if(vrd==vd){
							SMEdialog$run()                            
						}else{
						SMEdialog$reset()
						varSelector$setModel(variableSelector$getModel())
						SMEdialog$run()
						}
					}
					SMElistener <- new(ActionListener)
					SMElistener$setFunction(toJava(SMEfunction))
					SMEb$addActionListener(SMElistener)
					addComponent(subEZ, SMEb, 710, 790, 810, 210)
#					setSize(SMEb,400L,50L)
				
		#Add a 'Plot' button
		JButton <- J("javax.swing.JButton")
		plotButton <- new(JButton,"Plot")
		addComponent(ezDialog,plotButton,830,360,880,190)
		setSize(plotButton,200L,50L)

		#Listen for the plot button to be pressed
		plotFunction <- function(cmd,ActionEvent){
			plotEZ$setLocationRelativeTo(plotButton)
            pd <- plotVariableSelector$getModel()
            vd <- variableSelector$getModel()
            if(pd==vd){
            	plotEZ$run()                            
            }else{
                plotEZ$reset()
                plotVariableSelector$setModel(variableSelector$getModel())
                plotEZ$run()    
                        } 
#			plotEZ$setLocationRelativeTo(plotButton)
#			plotEZ$run()
		}
		plotListener <- new(ActionListener)
		plotListener$setFunction(toJava(plotFunction))
		plotButton$addActionListener(plotListener)

		#make Plot subDialog
		plotEZ <- new(SimpleRSubDialog,ezDialog,"ANOVA: Plot")
		setSize(plotEZ,660L,400L)
		
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
			textTop = textTop + listHeight + 3 * buffer
			xLabel <- new(JLabel,"X-axis label:")
			xValue <- new(TextFieldWidget)
			xValue$setTitle("x_lab")
			addComponent(plotEZ, xLabel, textTop, textLeft - 10, textTop + textHeight, textLeft - 210)
			addComponent(plotEZ, xValue, textTop, textRight, textTop + textHeight, textLeft)
			
			#add text field to enter new y-axis label
			textTop = textTop + textHeight + buffer; 
			yLabel <- new(JLabel,"Y-axis label:")
			yValue <- new(TextFieldWidget)
			yValue$setTitle("y_lab")
			addComponent(plotEZ, yLabel, textTop, textLeft - 10, textTop + textHeight, textLeft - 210)
			addComponent(plotEZ, yValue, textTop, textRight, textTop + textHeight, textLeft)
			
			#add text field to enter new legend label
			textTop = textTop + textHeight + buffer; 
			splitLabel <- new(JLabel,"legend label:")
			splitValue <- new(TextFieldWidget)
			splitValue$setTitle("split_lab")
			addComponent(plotEZ, splitLabel, textTop, textLeft - 10, textTop + textHeight, textLeft - 210)
			addComponent(plotEZ, splitValue, textTop, textRight, textTop + textHeight, textLeft)	

		#Add a 'Reshape Data' button
		reshape.button <- new(JButton,"Reshape Data")
		addComponent(ezDialog,reshape.button,890,295,940,75)
		setSize(reshape.button,220L,50L)
		
			#Listen for the button to be pressed
			ReshapeFunction <- function(cmd,ActionEvent){
				getMeltDialog()$run()
				}
			ReshapeListener <- new(ActionListener)
			ReshapeListener$setFunction(toJava(ReshapeFunction))
			reshape.button$addActionListener(ReshapeListener)

		#Add a 'Refresh Data Names' button
		refresh.button <- new(JButton,"Refresh Data Names")
		addComponent(ezDialog,refresh.button,950,345,990,25)
		
		#Listen for the button to be pressed
			refreshFunction <- function(cmd,ActionEvent) {
				variableSelector$refreshDataNames()
				if(exists("plotVariableSelector") plotVariableSelector$refreshDataNames()
				if(exists("varSelector") varSelector$refreshDataNames()
				}
			refreshListener <- new(ActionListener)
			refreshListener$setFunction(toJava(refreshFunction))
			refresh.button$addActionListener(refreshListener)

		#Add a 'Create New Subject ID' checkbox
		newID <- new(CheckBoxesWidget,c("Use rownames for Subject ID","box 2"))
		newID$setTitle("newID")
		newID$removeButton(1L)
		setSize(newID,450L,50L)
		addComponent(ezDialog,newID,840,990,890,550)
					
		#setting Run and Check functions
		ezDialog$setCheckFunction(toJava(.ezAnalysisCheckFunction))
		ezDialog$setRunFunction(toJava(.ezAnalysisRunFunction))
		
		return(ezDialog)
	}
