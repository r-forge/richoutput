.onLoad <- function(libname, pkgname) { 
	if(.deducer == .jnull())
		return(NULL)
	.jpackage(pkgname,lib.loc=libname) 	#loads jar file

	AlphaD <<- J("DeducerAlpha.Alpha")

	deducer.addMenuItem("Cronbach Alpha",,".getAlphaDialog()$run()","Analysis")
	if(.windowsGUI){			
		winMenuAddItem("Analysis", "Cronbach's Alpha", "deducer('Cronbach Alpha')")
	}else if(.jgr){	
		jgr.addMenuSeparator("Analysis")		
		jgr.addMenuItem("Analysis", "Cronbach's Alpha", "deducer('Cronbach Alpha')")
	}
}
