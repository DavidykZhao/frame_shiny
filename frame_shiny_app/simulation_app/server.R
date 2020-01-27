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
data_all$training_size = as.factor(data_all$training_size)
source('www/func1.R')
source('www/func2.R')









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
    
    output$overview_stage1 = renderPlot({
      
      plot_stage1_overview()
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

    ####### add a helper func to respond to the download button for ds_base_stage1
    button_downloader_stage1_ds_base = function(button_name) {
      
      output[[button_name]] <- downloadHandler(
        filename = function() { paste(button_name, '.png', sep='') },
        content = function(file) {
          # use re to extract the ds name from the button_name
          ggsave(file, plot = plot_stage1_ds_base(sub("_.*", "", button_name,perl=TRUE)), device = "png")
        }
      )
    }
    
    ######################## add a helper func to respond to the download button for overview
    button_downloader_stage1_overview = function(button_name) {
      
      output[[button_name]] <- downloadHandler(
        filename = function() { paste(button_name, '.png', sep='') },
        content = function(file) {
          ggsave(file, plot = plot_stage1_overview(), device = "png")
        }
      )
    }
###################################################################################
    #############################################
    # add downloadbutton response in server for stage1
    for (i in c('agnews_button_stage1',
                'customer_button_stage1',
                'amazon_button_stage1',
                'yelp_button_stage1',
                'dbpedia_button_stage1')){
        button_downloader_stage1(i)
    }
#################################################
    # add downloadbutton response in server for stage1_ds_base
    for (i in c('BERT_button_stage1',
                'LinearSVC_button_stage1',
                'NaiveBayes_button_stage1',
                'LogisticRegression_button_stage1',
                'RandomForest_button_stage1')){
      button_downloader_stage1_ds_base(i)
    }
    
    # add download button response in server for stage1_overview
    button_downloader_stage1_overview('overview_button_stage1')

    
    
    
    
    
    
####### Add reactivity for the buttons for showing m.o.d results ###
    # panel_show is the user defined input 
    panel_show <- reactiveValues(tab_box = NULL, title = NULL)
    # m.o.d button observe event
    
    observeEvent(input$m_o_d, {
      
        panel_show$title = tags$h2("Performances of models on a certain dataset")
        panel_show$tab_box <- {
          fluidRow(column(width = 10, offset = 1,
          br(),
          panel_show$title,
          tb_stage1))
          
        }
    })
    
    # m.a.d button observe event
    observeEvent(input$m_a_d, {
      panel_show$title = tags$h2("Performance of a certain model across datasets")
      panel_show$tab_box <- {
        fluidRow(column(width = 10, offset = 1,br(),
                 panel_show$title,
                 tb_stage1_ds_base))

      }
    })
    
    # ms.a.d button observe event
    observeEvent(input$ms_a_d, {
      panel_show$title = tags$h2("Performance of models across datasets")
      panel_show$tab_box <- {
        fluidRow(column(width = 10, offset = 1,
                 br(),
                 panel_show$title,
                 tb_comprehensive_stage1))
        
      }
    })
    
    
    # button_reactive_plot is the plot that is dependent on which button got clicked
    output$button_reactive_plot <- renderUI({
        if (is.null(panel_show$tab_box)) return()
        panel_show$tab_box
    })
    
    
    
    
    
    ########################################################
    ###########  Stage 2 ##############################
    ########################################################

    # add stage2 dataset facet plot
    output$agnews_stage2_facet = renderPlot({
      
      plot_stage2_facet_model('agnews')
    })
    
    output$dbpedia_stage2_facet = renderPlot({
      
      plot_stage2_facet_model('dbpedia')
    })
    
    output$yelp_stage2_facet = renderPlot({
      
      plot_stage2_facet_model('yelp')
    })
    
    output$amazon_stage2_facet = renderPlot({
      
      plot_stage2_facet_model('amazon')
    })
    
    output$customer_stage2_facet = renderPlot({
      
      plot_stage2_facet_model('customer')
    })
    
    ###### add stage2 dataset facet data plot #######
    output$bert_stage2_facet_data = renderPlot({
      
      plot_stage2_facet_data('BERT')
    })
    
    output$rf_stage2_facet_data = renderPlot({
      
      plot_stage2_facet_data('RandomForest')
    })
    
    output$linearsvc_stage2_facet_data = renderPlot({
      
      plot_stage2_facet_data('LinearSVC')
    })
    
    output$nb_stage2_facet_data = renderPlot({
      
      plot_stage2_facet_data('NaiveBayes')
    })
    
    output$logisticregression_stage2_facet_data = renderPlot({
      
      plot_stage2_facet_data('LogisticRegression')
    })
    
    # output$stage2_overview = renderImage('stage2_overview.png',
    #   deleteFile = F)
    

    
    ####### Add reactivity for the buttons in stage 2 ###
    # panel_show is the user defined input 
    panel_show_stage2 <- reactiveValues(tab_box = NULL, title = NULL)

    observeEvent(input$facet_model, {
      
      panel_show_stage2$title = tags$h2("Performances of models on a certain dataset")
      panel_show_stage2$tab_box <- {
        fluidRow(column(width = 12,
          br(),
                  panel_show_stage2$title,
                  tb_stage2_facet_model))
        
      }
    })
    
    
    # add the second observeEvent here
    observeEvent(input$facet_ds, {
      
      panel_show_stage2$title = tags$h2("Performances of a certain model across datasets")
      panel_show_stage2$tab_box <- {
        fluidRow(column(width = 12,
                        br(),
                        panel_show_stage2$title,
                        tb_stage2_facet_data))
        
      }
    })
    
    # add the third observeEvent here
    observeEvent(input$overview_stage2, {
      
      panel_show_stage2$title = tags$h2("Performances of models across datasets")
      panel_show_stage2$tab_box <- {
        fluidRow(column(width = 12,
                        br(),
                        panel_show_stage2$title,
                        tabBox(
                          title = "Overview",
                          # The id lets us use input$id on the server to find the current tab
                          id = "tabset_stage2_overview", 
                          width = 12,
                          fluidRow( 
                            tags$img(src='stage2_overview.png', width = 1200, height= 900)
                            )
                          )))
        
      }
    })
    
    
    output$button_reactive_plot_stage2 <- renderUI({
      if (is.null(panel_show_stage2$tab_box)) return()
      panel_show_stage2$tab_box
    })
    
    ### add download button response 
    button_downloader_stage2 = function(button_name) {
      
      output[[button_name]] <- downloadHandler(
        filename = function() { paste(button_name, '.png', sep='') },
        content = function(file) {
          # use re to extract the ds name from the button_name
          ggsave(file, width = 14, plot = plot_stage2_facet_model(sub("_.*", "", button_name,perl=TRUE)), device = "png")
        }
      )
    }
    
    for (i in c('customer_button_stage2',
                'amazon_button_stage2',
                'yelp_button_stage2',
                'dbpedia_button_stage2',
                'agnews_button_stage2')){
      button_downloader_stage2(i)
    }
    
    ##### stage2 facet data buttons
    ### add download button response 
    button_downloader_stage2_facet_data = function(button_name) {
      
      output[[button_name]] <- downloadHandler(
        filename = function() { paste(button_name, '.png', sep='') },
        content = function(file) {
          # use re to extract the ds name from the button_name
          ggsave(file, width = 14, plot = plot_stage2_facet_data(sub("_.*", "", button_name,perl=TRUE)), device = "png")
        }
      )
    }
    
    for (i in c('LogisticRegression_button_stage2',
                'LinearSVC_button_stage2',
                'NaiveBayes_button_stage2',
                'RandomForest_button_stage2',
                'BERT_button_stage2')){
      button_downloader_stage2_facet_data(i)
    }
    
    ## add a download response to the overview plot in stage2 #TODO
    # output[[button_name]] <- downloadHandler(
    #   filename = function() { paste(button_name, '.png', sep='') },
    #   content = function(file) {
    #     # use re to extract the ds name from the button_name
    #     ggsave(file, width = 14, plot = plot_stage2_facet_data(sub("_.*", "", button_name,perl=TRUE)), device = "png")
    #   }
    
    
    
    
    
}) # final brackets
    
