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
		
		#add a list for the variables
		varList<- new(VariableListWidget,"Variables",variableSelector)
		varList$setTitle("variables")
		addComponent(CVDialog, varList, 80, 990, 400, 420)

		#how to combine the variables
		combo <- new(ComboBoxWidget,c("Sum","Product","Mean"))
		combo$setDefaultModel("Sum")
		combo$setTitle("Combination")
		addComponent(CVDialog, combo, 410, 990, 460, 500)

		#divide 
		dividend<- new(SingleVariableWidget,"Dividend",variableSelector)
		dividend$setTitle("dividend")
		divisor<- new(SingleVariableWidget,"Divisor",variableSelector)
		divisor$setTitle("divisor")
		addComponent(CVDialog, dividend, 470, 690, 570, 400)
		addComponent(CVDialog, divisor, 470, 990, 570, 700)

		#difference
		minuend<- new(SingleVariableWidget,"Minuend",variableSelector)
		minuend$setTitle("minuend")
		subtrahend<- new(SingleVariableWidget,"Subtrahend",variableSelector)
		subtrahend$setTitle("subtrahend")
		addComponent(CVDialog, minuend, 580, 690, 680, 400)
		addComponent(CVDialog, subtrahend, 580, 990, 680, 700)


		
		#setting Run and Check functions
		CVDialog$setCheckFunction(toJava(.CVCheckFunction))
		CVDialog$setRunFunction(toJava(.CVRunFunction))
		
		return(CVDialog)
	}

	.CVCheckFunction <- function(state){		
		d1 = !is.null(state$divisor); d2 = !is.null(state$dividend)
		s1 = !is.null(state$minuend); s2 = !is.null(state$subtrahend)
		# make sure that a sum/product/mean and a division or subtraction are not attempted simultaneously
		if(!is.null(state$variables) & any(d1,d2,s1,s2)) return("Just one operation at a time")

		# make sure that subtraction and division are not attempted at the same time
		if((d1+d2)*(s1+s2) > 0) return("Subtraction or division, but not both")

		if(d1 + d2 == 1) {# if only one of the division cells is filled
			return("Division requires both divisor and dividend")
			}
		if(s1 + s2 == 1) {# if only one of the subtraction cells is filled
			return("Subtraction requires both minuend and subtrahend")
			}
		if(d1 + d2 + s1 + s2 == 0) { # if all division and subtraction fields are empty
			if(length(state$variables) < 2) {
				return("Please select at least 2 variables")
				}
			}

		#make sure label for new mean is entered
		if(state$label == "")
			return("Please enter label for new mean")
		if(regexpr("[[:space:]]",state$label) > 0) return("No spaces in label for new mean")
		
		return("")
		}

#	numericCheck <- function(data,variables) {
	#Trying to build a way to check whether variables are numeric and returning an error if not.
#		vars <- eval(substitute(variables), data, parent.frame())
#		all(sapply(vars, function(x) is.numeric(x)))
#		}

	.CVRunFunction <- function(state){
		if(!is.null(state$variables)) {
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
		if(!is.null(state$divisor)) {
			cmd = paste(state$data,"[['",state$label,"']] <- ",state$data,"[['",state$dividend,"']] / ",state$data,"[['",state$divisor,"']]\n",sep="")
			cmd = paste(cmd,"attr(",state$data,"[['",state$label,"']], \"First item divided by second item\") = c('",state$dividend,"','",state$divisor,"')\n",sep="")
			execute(cmd)
			}
		if(!is.null(state$minuend)) {
			cmd = paste(state$data,"[['",state$label,"']] <- ",state$data,"[['",state$minuend,"']] - ",state$data,"[['",state$subtrahend,"']]\n",sep="")
			cmd = paste(cmd,"attr(",state$data,"[['",state$label,"']], \"First item minus second item\") = c('",state$minuend,"','",state$subtrahend,"')\n",sep="")
			execute(cmd)
			}
	}


	getCVDialog <- function(){
		if(!exists(".CVDialog")){
			#make CVDialog
			.CVDialog <- makeCVDialog()
			assign(".CVDialog",.CVDialog,globalenv())		
		}
		return(.CVDialog)
	}

#	deducer.addMenuItem("Combine Variables",,"getCVDialog()$run()","Data")
#	if(.windowsGUI) winMenuAddItem("Data", "Combine Variables", "deducer('Combine Variables')")
#	if(.jgr) jgr.addMenuItem("Data", "Combine Variables", "deducer('Combine Variables')")
