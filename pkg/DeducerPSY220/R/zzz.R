.First.lib <- function(libname, pkgname) {
	.jpackage(pkgname, lib.loc = libname)
		deducer.addMenuItem("Compute Mean",,"getMeanDialog()$run()","Data")
		deducer.addMenuItem("Combine Variables",,"getCVDialog()$run()","Data")
		deducer.addMenuItem("Paired Samples Test",,"getPairedDialog()$run()","Analysis")
		if(.windowsGUI){			
			winMenuAddItem("Data", "Compute Mean", "deducer('Compute Mean')")
			winMenuAddItem("Data", "Combine Variables", "deducer('Combine Variables')")
			winMenuAddItem("Analysis", "Paired Samples Test", "deducer('Paired Samples Test')")
		}else if(.jgr){			
			jgr.addMenuItem("Data", "Compute Mean", "deducer('Compute Mean')")
			jgr.addMenuItem("Data", "Combine Variables", "deducer('Combine Variables')")
			jgr.addMenuItem("Analysis", "Paired Samples Test", "deducer('Paired Samples Test')")
		}
}
