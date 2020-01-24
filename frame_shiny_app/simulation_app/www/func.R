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
             plotOutput('agnews_stage1'))
  ),
  
  tabPanel("DBPedia",
           fluidRow(           
             plotOutput('dbpedia_stage1'))),
  tabPanel("Yelp",
           fluidRow(           
             plotOutput('yelp_stage1'))),
  tabPanel("Amazon",
           fluidRow(           
             plotOutput('amazon_stage1'))),
  tabPanel("Customer",
           fluidRow(           
             plotOutput('customer_stage1'))))
########################################################



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