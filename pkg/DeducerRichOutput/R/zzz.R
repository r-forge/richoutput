#
# Author: Ian Fellows
###############################################################################



print_to_html <- function(x,...){
	cat("</pre>\n")
	if(class(x)[1] %in% c("numeric","logical","character","integer"))
		print(xtable(t(as.matrix(x)),...),type="html",...)
	else
		print(xtable(x,...),type="html",...)
	cat("<pre>\n")
}

#print.numeric <- function(x,...) print_to_html(x,...)
#print.logical <- function(x,...) print_to_html(x,...)
#print.character <- function(x,...) print_to_html(x,...)
#print.integer <- function(x,...) print_to_html(x,...)
#print.data.frame <- function(x,...) print_to_html(x,...)
#print.table <- function(x,...) print_to_html(x,...)
#print.matrix <- function(x,...) print_to_html(x,...)
#print.lm <- function(x,...) print_to_html(x,...)
#print.aov <- function(x,...) print_to_html(x,...)
#print.summary.aov <- function(x,...) print_to_html(x,...)
#print.glm <- function(x,...) print_to_html(x,...)
#print.summary.glm <- function(x,...) print_to_html(x,...)
#print.anova <- function(x,...) print_to_html(x,...)
#print.summary.anova <- function(x,...) print_to_html(x,...)


.onLoad <- function(libname, pkgname) { 
	#loads RichOutput.jar
	.jpackage(pkgname,lib.loc=libname)
	
	#replaces the input and output of the console 
	#with rich output enabled components.
	if(.jgr){
		J("RichOutput.OutputController")$replaceConsole()
		J("RichOutput.OutputController")$replaceModelPreview()
	}
}
