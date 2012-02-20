.First.lib <- function(libname, pkgname) {
	if(.deducer == .jnull())
		return(NULL)
	require(reshape)
	require(stringr)
	require(Hmisc)
	.jpackage(pkgname, lib.loc = libname)
		deducer.addMenuItem("ANOVA",,"getEZAnalysisDialog()$run()","Analysis")
		deducer.addMenuItem("Reshape Data",,"getMeltDialog()$run()","Data")
		if(.windowsGUI){			
			winMenuAddItem("Analysis", "ANOVA", "deducer('ANOVA')")
			winMenuAddItem("Data", "Reshape Data", "deducer('Reshape Data')")
		}else if(.jgr){			
			jgr.addMenuItem("Analysis", "ANOVA", "deducer('ANOVA')")
			jgr.addMenuItem("Data", "Reshape Data", "deducer('Reshape Data')")
		}
}
