#######       functions for stage 2   ##########
##########                             ##########
#################################################



# read in the data
data_all = read.csv('./www/all_stages.csv')

# UI funtions
########################################################
# tabBox for stage 1 - model performances over datasets
tb_stage1 = tabBox(
  title = "Datasets",
  # The id lets us use input$tabset1 on the server to find the current tab
  id = "tabset_stage2_facet", 
  width = 12, 
  tabPanel("AG News",
           fluidRow(   
             plotOutput('agnews_stage2_facet')),
           downloadBttn("agnews_button_stage2", "Download", style = 'unite', size = 'sm')
           
  ),
  
  tabPanel("DBPedia",
           fluidRow(   
             plotOutput('dbpedia_stage2_facet'),
             downloadBttn("dbpedia_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Yelp",
           fluidRow( 
             plotOutput('yelp_stage2_facet'),
             downloadBttn("yelp_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Amazon",
           fluidRow(   
             plotOutput('amazon_stage2_facet'),
             downloadBttn("amazon_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Customer",
           fluidRow(  
             plotOutput('customer_stage2_facet'),
             downloadBttn("customer_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )))
########################################################