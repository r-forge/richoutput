#############################################
#
# 			Call Wide to Long & Long to Wide Dialogs
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

.getLtWDialog <- function(){ # Ensures that 2 copies of the dialog do not exist simultaneously
	if(!exists(".LtWDialog")){ # checks to see if a dialog already exists
		.LtWDialog <- new(LongToWide) # if not, creates one
		.LtWDialog$setLocationRelativeTo(.jnull())
		assign(".LtWDialog",.LtWDialog,globalenv())	# and registers it	
	}
	return(.LtWDialog) 
}
