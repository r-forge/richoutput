#############################################
#
# 			Call Alpha Dialog
#
#############################################

.getAlphaDialog <- function(){ # Ensures that 2 copies of the dialog do not exist simultaneously
	if(!exists(".AlphaDialog")){ # checks to see if a dialog already exists
		.AlphaDialog <- new(AlphaD) # if not, creates one
		.AlphaDialog$setLocationRelativeTo(.jnull())
		assign(".AlphaDialog",.AlphaDialog,globalenv())	# and registers it	
	}
	return(.AlphaDialog) 
}
