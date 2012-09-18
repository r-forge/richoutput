gg2way <- function(data,exclude,x,y,xwithin = FALSE, split = NULL,x_lab = NULL, y_lab = NULL, split_lab = NULL)
	{
		if(is.null(split)) split = "NULL"
		if(length(split) == 0) split = "NULL"
		cmd = paste(if(!is.null(exclude)) paste(data," = ",data,"[-c(",exclude,"),]\n",sep=""),
#		"dev.new()\n",
#		"g <- ggplot() + theme_bw() +\n",
		"ggplot() + theme_bw() +\n",
		"geom_errorbar(aes(y = ",y,", x = ", x,", linetype = ",split, ", group = ",split,"),",
			"data=",data,",width = 0.4, fun.data = mean_cl_normal, conf.int = 0.95, stat = 'summary',",
			"position = position_dodge(width = 0.5))+\n",
		 "geom_point(aes(x = ", x, ", y = ",y, ", shape = ",split, ", group = ",split,"),",
			"data=",data,",size = 3.0, fun.data = mean_cl_normal, conf.int = 0.95,stat = 'summary', position = position_dodge(width = 0.5))",sep="")
		if(xwithin) {
			cmd = paste(cmd,"+\ngeom_line(aes(x = ", x, ", y = ",y, ", linetype = ",split, ", group = ",split,"),",
			"data=",data,", fun.data = mean_cl_normal, conf.int = 0.95,stat = 'summary', position = position_dodge(width = 0.5))",sep="")
				}
		if(!is.null(x_lab)) cmd = paste(cmd,"+\nscale_x_discrete(name = \"",x_lab,"\")",sep="")
		if(!is.null(y_lab)) cmd = paste(cmd,"+\nscale_y_continuous(name = \"",y_lab,"\")",sep="")  
		if(!is.null(split_lab)) cmd = paste(cmd,"+\nscale_linetype(name = \"",split_lab,"\") + scale_shape(name = \"",split_lab,"\")",sep="") 
#		cmd = paste(cmd,"\nprint(g)")
		return(cmd)	
		}
