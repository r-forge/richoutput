.First.lib <- function(libname, pkgname) {
	require(reshape)
	.jpackage(pkgname, lib.loc = libname)
		deducer.addMenuItem("ANOVA",,"getEZAnalysisDialog()$run()","Analysis")
		if(.windowsGUI){			
			winMenuAddItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}else if(.jgr){			
			jgr.addMenuItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}
}
