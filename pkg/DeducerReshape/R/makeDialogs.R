#############################################
#
# 			Call Wide to Long Dialog
#
#############################################

.getWtLDialog <- function(){ # Ensures that 2 copies of the dialog do not exist simultaneously
	if(!exists(".WtLDialog")){ # checks to see if a dialog already exists
		.WtLDialog <- new(WideToLong) # if not, creates one
		.WtLDialog$setLocationRelativeTo(.jnull())
		assign(".WtLDialog",.WtLDialog,globalenv())	# and registers it	
	}
	return(.WtLDialog) 
}
