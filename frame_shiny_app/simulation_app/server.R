#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
### read in the overall data
data_all = read.csv('www/all_stages.csv')
source('www/func.R')


############### Academic_plotting theme #######################
academic_theme =  theme(plot.title = element_text(face="bold", size=15), # use theme_get() to see available options
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
#######################


############## Set the sota_error dict #######################
sota_errors = c(0.0062, 0.0449, 1-0.732, 0 ,0.3226 )
names(sota_errors) = ds_names
################################################################







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
    
    #### add ds_base plot to the output
    output$bert_stage1 = renderPlot({
        
        plot_stage1_ds_base('BERT')
    })
    
    output$linear_svc_stage1 = renderPlot({
        
        plot_stage1_ds_base('LinearSVC')
    })
    
    output$logistic_stage1 = renderPlot({
        
        plot_stage1_ds_base('LogisticRegression')
    })
    
    output$nb_stage1 = renderPlot({
        
        plot_stage1_ds_base('NaiveBayes')
    })
    
    output$rf_stage1 = renderPlot({
        
        plot_stage1_ds_base('RandomForest')
    })
    
    ####### add a helper func to respond to the download button
    button_downloader_stage1 = function(button_name) {
        
        output[[button_name]] <- downloadHandler(
            filename = function() { paste(button_name, '.png', sep='') },
            content = function(file) {
                # use re to extract the ds name from the button_name
                ggsave(file, plot = plot_stage1(sub("_.*", "", button_name,perl=TRUE)), device = "png")
            }
        )
    }
    ###########################################
    # add button response in server
    for (i in c('agnews_button_stage1',
                'customer_button_stage1',
                'amazon_button_stage1',
                'yelp_button_stage1',
                'dbpedia_button_stage1')){
        button_downloader_stage1(i)
    }

    
    
})
    
