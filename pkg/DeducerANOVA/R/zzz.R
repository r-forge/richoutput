.First.lib <- function(libname, pkgname) {
	if(.deducer == .jnull())
		return(NULL)
	require(stringr)
	require(Hmisc)
	.jpackage(pkgname, lib.loc = libname)
		deducer.addMenuItem("ANOVA",,"getEZAnalysisDialog()$run()","Analysis")
		if(.windowsGUI){			
			winMenuAddItem("Analysis", "ANOVA", "deducer('ANOVA')")
			winMenuAddItem("Data", "Reshape Data", "deducer('Reshape Data')")
		}else if(.jgr){			
			jgr.addMenuItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}
}