.SplitNotes <- function(dat) {
	label="{"
	for(i in 1:length(dat)){
		label=paste(label,names(dat)[i],
		"(",paste(levels(dat[[i]]),collapse=",",sep=""),")",
		if(i<length(dat)) ", ",
		sep="")
		}
	label=paste(label,"}",sep="")
	return(label)	
	}