makeMedDialog <- function() {
		MedDialog <- new(SimpleRDialog)
		MedDialog$setSize(600L,600L)
		MedDialog$setTitle("Test Mediation")
	
		#add variable selector
		variableSelector <- new(VariableSelectorWidget)
		variableSelector$setTitle("data")
		addComponent(MedDialog,variableSelector, 10, 380, 820, 10)
		
		#predictor 
		predictor<- new(SingleVariableWidget,"Predictor",variableSelector)
		predictor$setTitle("predictor")
		mediator<- new(SingleVariableWidget,"Mediator",variableSelector)
		mediator$setTitle("mediator")
		outcome<- new(SingleVariableWidget,"Outcome",variableSelector)
		outcome$setTitle("outcome")
		addComponent(MedDialog, predictor, 10, 800, 110, 500)
		addComponent(MedDialog, mediator, 120, 800, 220, 500)
		addComponent(MedDialog, outcome, 230, 800, 330, 500)
		
		#setting Run and Check functions
		MedDialog$setCheckFunction(toJava(.MedCheckFunction))
		MedDialog$setRunFunction(toJava(.MedRunFunction))
		
		return(MedDialog)
	}

	.MedCheckFunction <- function(state){		
		p = is.null(state$predictor); m = is.null(state$mediator)
		o = is.null(state$outcome); 
		if(any(p,m,o)) return("Missing one or more variables")
	
		return("")
		}

	mediation <- function(predictor,mediator,outcome,data) {
		x <- eval(substitute(predictor), data, parent.frame())
		m <- eval(substitute(mediator), data, parent.frame())
		y <- eval(substitute(outcome), data, parent.frame())
		pred <- as.character(substitute(predictor))
		med <- as.character(substitute(mediator))
		out <- as.character(substitute(outcome))
		tmp.data <- as.data.frame(cbind(x,m,y))
		results <- proximal.med(tmp.data)
		label.a <- paste(pred," -> ",med,sep="")
		label.b <- paste("(",pred," + ",med,") -> ",out,sep="")
		label.t <- paste("Total effect of ",pred," on ",out,sep="")
		label.t.prime <- paste("Direct effect of ",pred," on ",out," accounting for ",med,sep="")
		label.ab <- paste("Indirect effect of ",pred," on ",out," through ",med,sep="")
		label.list <- c(label.a,label.b,label.t,label.t.prime,label.ab)
		estimates <- sapply(results[1:5,1], function(x) as.numeric(x))
		estimates.f <- format(estimates,nsmall=2,digits=3)
		t.values <- sapply(results[1:5,3], function(x) abs(as.numeric(x)))
		p.values <- 2*(1-pt(t.values,nrow(tmp.data)))
		p.values.f <- format.pval(p.values,eps = .001,digits=3)
		output <- as.data.frame(cbind(label.list,estimates.f,p.values.f))
		names(output) <- c("effect","parameter","p-value")
		return(output)
		}

	.MedRunFunction <- function(state){
		cmd = paste("mediation(",state$predictor,",",state$mediator,",",state$outcome,",",state$data,")\n",sep="")
		execute(cmd)
		}

	getMedDialog <- function(){
		if(!exists(".MedDialog")){
			#make MedDialog
			.MedDialog <- makeMedDialog()
			assign(".MedDialog",.MedDialog,globalenv())		
		}
		return(.MedDialog)
	}

if(!require(QuantPsyc)) {
	print("Mediation analysis requires package QuantPsyc. Attempting to download...")
	install.packages("QuantPsyc")
	}
require(QuantPsyc)


deducer.addMenuItem("Mediation",,"getMedDialog()$run()","Data")
if(.windowsGUI) winMenuAddItem("Analysis", "Mediation", "deducer('Mediation')")
if(.jgr) jgr.addMenuItem("Analysis", "Mediation", "deducer('Mediation')")
