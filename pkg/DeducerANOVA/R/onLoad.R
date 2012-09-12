.onLoad <- function(libname, pkgname) {
	if(.deducer == .jnull())
		return(NULL)
	.jpackage(pkgname, lib.loc = libname)
	
	ANOVAd <<- J("DeducerANOVA.ANOVA")

	# Setting options to permit Type-3 SS that correspond to SAS and SPSS output:	
	options(contrasts=c("contr.sum","contr.poly"))
	
		deducer.addMenuItem("ANOVA",,".getANOVADialog()$run()","Analysis")
		if(.windowsGUI){			
			winMenuAddItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}else if(.jgr){	
			jgr.addMenuSeparator("Analysis")		
			jgr.addMenuItem("Analysis", "ANOVA", "deducer('ANOVA')")
		}
}
