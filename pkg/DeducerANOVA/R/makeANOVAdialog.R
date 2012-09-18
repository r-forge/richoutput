#############################################
#
# 			Call ANOVA Dialog
#
#############################################

.getANOVADialog <- function(){ # Ensures that 2 copies of the dialog do not exist simultaneously
	if(!exists(".ANOVADialog")){ # checks to see if a dialog already exists
		.ANOVADialog <- new(ANOVAd) # if not, creates one
		.ANOVADialog$setLocationRelativeTo(.jnull())
		assign(".ANOVADialog",.ANOVADialog,globalenv())	# and registers it	
	}
	return(.ANOVADialog) 
}