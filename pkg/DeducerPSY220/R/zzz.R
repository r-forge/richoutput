.First.lib <- function(libname, pkgname) {
	require(Amelia)
	require(ez)
	require(reshape)
	#loads psy220.jar
	.jpackage(pkgname, lib.loc = libname)
		deducer.addMenuItem("Compute Mean",,"getMeanDialog()$run()","Data")
		deducer.addMenuItem("Impute Data",,"getAmeliaDialog()$run()","Data")
		deducer.addMenuItem("Paired Samples Test",,"getPairedDialog()$run()","Analysis")
		deducer.addMenuItem("Convert to Long Form",,"getMeltDialog()$run()","Data")
		deducer.addMenuItem("ANOVA",,"getEZAnalysisDialog()$run()","Analysis")
		if(.windowsGUI){			
			winMenuAddItem("Data", "Compute Mean", "deducer('Compute Mean')")
			winMenuAddItem("Data", "Impute Data", "deducer('Impute Data')")
			winMenuAddItem("Analysis", "Paired Samples Test", "deducer('Paired Samples Test')")
			winMenuAddItem("Data", "Convert to Long Form", "deducer('Convert to Long Form')")
			winMenuAddItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}else if(.jgr){			
			jgr.addMenuItem("Data", "Compute Mean", "deducer('Compute Mean')")
			jgr.addMenuItem("Data", "Impute Data", "deducer('Impute Data')")
			jgr.addMenuItem("Analysis", "Paired Samples Test", "deducer('Paired Samples Test')")
			jgr.addMenuItem("Data", "Convert to Long Form", "deducer('Convert to Long Form')")
			jgr.addMenuItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}
}
