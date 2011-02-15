outcome.labels <- function(outcomes)
{
if (!is.null(outcomes)) {
	if (length(outcomes) == 1)
			{
			outcome.label = outcomes[1]
			}
	if (length(outcomes) == 2)
			{
			outcome.label = paste(outcomes[1]," & ",outcomes[2], sep="")
			}	
	if (length(outcomes) > 2) 
			{
			outcome.label = paste(outcomes[1],", ",outcomes[2],", & ",
			length(outcomes)-2," more",sep="")
			}
	} else outcome.label = NULL

return(outcome.label)

}
