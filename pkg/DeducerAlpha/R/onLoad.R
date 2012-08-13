.onLoad <- function(libname, pkgname) { 
	if(.deducer == .jnull())
		return(NULL)
	.jpackage(pkgname,lib.loc=libname) 	#loads ReshapeDialog.jar

	AlphaD <<- J("DeducerAlpha.Alpha")

	deducer.addMenuItem("Cronbach Alpha",,".getAlphaDialog()$run()","Analysis")
	if(.windowsGUI){			
		winMenuAddItem("Analysis", "Cronbach Alpha", "deducer('Cronbach Alpha')")
	}else if(.jgr){	
		jgr.addMenuSeparator("Analysis")		
		jgr.addMenuItem("Analysis", "Cronbach Alpha", "deducer('Cronbach Alpha')")
	}
}
