.onLoad <- function(libname, pkgname) { 
	if(.deducer == .jnull())
		return(NULL)
	.jpackage(pkgname,lib.loc=libname) 	#loads ReshapeDialog.jar
#	scatter <- new(J("DeducerReshape.PlotRDialog"))
	WideToLong <<- new(J("DeducerReshape.WideToLong"))
#	deducer.addMenuItem("PlotRDialog",,"scatter$run()","Analysis")
	deducer.addMenuItem("WideToLong",,"WideToLong$run()","Data")
	if(.windowsGUI){			
#		winMenuAddItem("Analysis", "PlotRDialog", "deducer('PlotRDialog')")
		winMenuAddItem("Data", "Reshape W to L", "deducer('WideToLong')")
	}else if(.jgr){			
#		jgr.addMenuItem("Analysis", "PlotRDialog", "deducer('PlotRDialog')")
		jgr.addMenuItem("Data", "Reshape W to L", "deducer('WideToLong')")
	}
}
