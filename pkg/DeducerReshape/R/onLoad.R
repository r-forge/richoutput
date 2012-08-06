.onLoad <- function(libname, pkgname) { 
	if(.deducer == .jnull())
		return(NULL)
	.jpackage(pkgname,lib.loc=libname) 	#loads ReshapeDialog.jar

	WideToLong <<- J("DeducerReshape.WideToLong2")
	LongToWide <<- J("DeducerReshape.LongToWide")

	deducer.addMenuItem("Reshape W to L",,".getWtLDialog()$run()","Data")
	deducer.addMenuItem("Reshape L to W",,".getLtWDialog()$run()","Data")
	if(.windowsGUI){			
		winMenuAddItem("Data", "Reshape W to L", "deducer('Reshape W to L')")
		winMenuAddItem("Data", "Reshape L to W", "deducer('Reshape L to W')")
	}else if(.jgr){			
		jgr.addMenuItem("Data", "Reshape W to L", "deducer('Reshape W to L')")
		jgr.addMenuItem("Data", "Reshape L to W", "deducer('Reshape L to W')")
	}
}
