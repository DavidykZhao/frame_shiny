#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
data_all = read.csv('www/all_stages.csv')

############### Academic_plotting theme #######################
academic_theme =  theme(plot.title = element_text(face="bold", size=10), # use theme_get() to see available options
                        axis.title.x = element_blank(),
                        axis.title.y = element_text(face="bold", size=10, angle=90),
                        panel.grid.major.y = element_blank(), # switch off major gridlines
                        panel.grid.minor = element_blank(), # switch off minor gridlines
                        legend.position = 'bottom', # manually position the legend (numbers being from 0,0 at bottom left of whole plot to 1,1 at top right)
                        legend.title = element_blank(), # switch off the legend title
                        legend.text = element_text(size=8),
                        legend.key.size = unit(0.5, "lines"),
                        legend.key = element_blank(),
                        axis.text.x = element_text(size = 12),
                        panel.border = element_blank() )
####################################################################################

########### dict for converting ds name to title name
ds_names = as.vector(unique(data_all$dataset))
title_names = c("DBPedia", "AG News", "Yelp-full", "Customer Complaints", 'Amazon-full')
names(title_names) = ds_names  # ----> title_names is the dict name title_names['dbpedia]
#################


############## Set the sota_error dict #######################
sota_errors = c(0.0062, 0.0449, 1-0.732, 0 ,0.3226 )
names(sota_errors) = ds_names
################################################################


############ Func for plotting stage1 across datasets ############
plot_stage1 = function(ds_name) {
    
    data_all %>%
        filter(training_size > 5000 & dataset == ds_name) -> ds
    ggplot(ds, aes(x = model_name))+
        geom_boxplot(aes(y = accuracy)) +
        theme_bw() + 
        labs(title = paste("Algorithm performances on",  title_names[ds_name],  "dataset"))+
        academic_theme +
        geom_hline(yintercept= mean(ds$accuracy),linetype="dotted" )+
        annotate("text", x= 4, y= mean(ds$accuracy) - 0.005, size = 3, label="Average")+
        geom_hline(yintercept = 1 - sota_errors[ds_name], linetype = 'dotted')+
        annotate('text', x = 1, y = 1 - sota_errors[ds_name], label = 'SOTA',size = 3)+
        theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
}

#################################################################

# Define server logic required to draw a histogram
shinyServer(function(input, output) {

    
    output$agnews_stage1 = renderPlot({
 
        plot_stage1('agnews')
    })
    
    output$dbpedia_stage1 = renderPlot({
        
        plot_stage1('dbpedia')
    })
    
    output$yelp_stage1 = renderPlot({
        
        plot_stage1('yelp')
    })
   
    output$amazon_stage1 = renderPlot({
        
        plot_stage1('amazon')
    })
    
    output$customer_stage1 = renderPlot({
        
        plot_stage1('customer')
    })
    
})
    
