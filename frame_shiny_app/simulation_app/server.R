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
data_all = read.csv('./www/all_stages.csv')
source('www/func.R')








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
    # add downloadbutton response in server for stage1
    for (i in c('agnews_button_stage1',
                'customer_button_stage1',
                'amazon_button_stage1',
                'yelp_button_stage1',
                'dbpedia_button_stage1')){
        button_downloader_stage1(i)
    }
#################################################
  
####### Add reactivity for the buttons for showing m.o.d results ###
    # panel_show is the user defined input 
    panel_show <- reactiveValues(tab_box = NULL, title = NULL)
    # m.o.d button observe event
    
    observeEvent(input$m_o_d, {
      
        panel_show$title = tags$h2("Performances of models on a certain dataset")
        panel_show$tab_box <- {
          fluidRow(br(),
          panel_show$title,
          tb_stage1)
          
        }
    })
    
    # m.a.d button observe event
    observeEvent(input$m_a_d, {
      panel_show$title = tags$h2("Performance of a certain model across datasets")
      panel_show$tab_box <- {
        fluidRow(br(),
                 panel_show$title,
                 tb_stage1_ds_base)

      }
    })
    
    
    
    output$button_reactive_plot <- renderUI({
        if (is.null(panel_show$tab_box)) return()
        panel_show$tab_box
    })
    
    

    
    
    
    
    
})
    
