# UI funtions
########################################################
# tabBox for stage 1 - model performances over datasets
tb_stage1 = tabBox(
  title = "Datasets",
  # The id lets us use input$tabset1 on the server to find the current tab
  id = "tabset1", 
  width = 10, 
  tabPanel("AG News",
           fluidRow(   
           plotOutput('agnews_stage1')),
           downloadButton("agnews_button_stage1", "Download")
           
  ),
  
  tabPanel("DBPedia",
           fluidRow(   
             plotOutput('dbpedia_stage1'),
             downloadButton("dbpedia_button_stage1", "Download")
           )),
  
  tabPanel("Yelp",
           fluidRow( 
             plotOutput('yelp_stage1'),
             downloadButton("yelp_button_stage1", "Download")
           )),
  
  tabPanel("Amazon",
           fluidRow(   
             plotOutput('amazon_stage1'),
             downloadButton("amazon_button_stage1", "Download")
           )),
  
  tabPanel("Customer",
           fluidRow(  
             plotOutput('customer_stage1'),
             downloadButton("customer_button_stage1", "Download")
           )))
########################################################
#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%







#%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
# Server functions
########################################################
# tabBox for stage 1 - model performances across datasets
tb_stage1_ds_base = tabBox(
  title = "Models",
  # The id lets us use input$tabset1 on the server to find the current tab
  id = "tabset1_ds_base", 
  width = 10, 
  tabPanel("BERT",
           fluidRow(           
             plotOutput('bert_stage1'))
  ),
  
  tabPanel("LinearSVC",
           fluidRow(           
             plotOutput('linear_svc_stage1'))),
  tabPanel("LogisticRegression",
           fluidRow(           
             plotOutput('logistic_stage1'))),
  tabPanel("NaiveBayes",
           fluidRow(           
             plotOutput('nb_stage1'))),
  tabPanel("RandomForest",
           fluidRow(           
             plotOutput('rf_stage1'))))
########################################################

############ Func for plotting stage1 over datasets ############
plot_stage1 = function(ds_name) {
  ## add control for the customer dataset because it does not have SOTA.
  if (ds_name == 'customer'){
    data_all %>%
      filter(training_size > 5000 & dataset == ds_name) -> ds
    ggplot(ds, aes(x = model_name))+
      geom_boxplot(aes(y = accuracy)) +
      theme_bw() + 
      labs(title = paste("Algorithm performances on",  title_names[ds_name],  "dataset"))+
      academic_theme +
      geom_hline(yintercept= mean(ds$accuracy),linetype="dotted" )+
      annotate("text", x= 5, y= mean(ds$accuracy) - 0.005, size = 3, label="Average")+
      theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  } else {
    
    data_all %>%
      filter(training_size > 5000 & dataset == ds_name) -> ds
    ggplot(ds, aes(x = model_name))+
      geom_boxplot(aes(y = accuracy)) +
      theme_bw() + 
      labs(title = paste("Algorithm performances on",  title_names[ds_name],  "dataset"))+
      academic_theme +
      geom_hline(yintercept= mean(ds$accuracy),linetype="dotted" )+
      annotate("text", x= 5, y= mean(ds$accuracy) - 0.005, size = 3, label="Average")+
      geom_hline(yintercept = 1 - sota_errors[ds_name], linetype = 'dotted')+
      annotate('text', x = 1, y = 1 - sota_errors[ds_name], label = 'SOTA',size = 3)+
      theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  }
}

#################################################################

########### Func for plotting stage1 across datasets #####
plot_stage1_ds_base = function(model) {
  
  data_all  %>%
    filter(training_size > 5000 & model_name == model) %>%
    ggplot(aes(x = dataset))+
    geom_boxplot(aes(y = accuracy)) +
    theme_bw() + 
    labs(title = paste(model, "'s performances across different datasets"))+
    academic_theme +
    theme(plot.margin=grid::unit(c(0.5,0.5,0.3,0.3), "cm"))
  
}
######################################################################




