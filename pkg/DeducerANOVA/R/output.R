output <- function(lis) {
	for(i in 1:length(lis)) {
		ANOVAd$addTab(names(lis)[i],h.df(lis[[i]]))
		}
	}
