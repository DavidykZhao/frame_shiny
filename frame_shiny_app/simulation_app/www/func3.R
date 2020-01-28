#######       functions for stage 3   ##########
##########                             ##########
#################################################

scale_colour_Publication <- function(...){
  library(scales)
  discrete_scale("colour","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
}

scale_fill_Publication <- function(...){
  library(scales)
  discrete_scale("fill","Publication",manual_pal(values = c("#386cb0","#fdb462","#7fc97f","#ef3b2c","#662506","#a6cee3","#fb9a99","#984ea3","#ffff33")), ...)
}

# read in the data
data_all = read.csv('./www/all_stages.csv')
data_all$training_size = as.factor(data_all$training_size)
data_all$class_num = as.factor(data_all$class_num)

# UI funtions
########################################################
# tabBox for stage 1 - model performances over datasets
tb_stage3_facet_model = tabBox(
  title = "Datasets",
  # The id lets us use input$id on the server to find the current tab
  id = "tabset_stage3_facet", 
  width = 12,
  tabPanel("AG News",
           fluidRow(   
             plotOutput('agnews_stage3_facet')),
           downloadBttn("agnews_button_stage3", "Download", style = 'unite', size = 'sm')
           
  ),
  
  tabPanel("DBPedia",
           fluidRow(   
             plotOutput('dbpedia_stage3_facet'),
             downloadBttn("dbpedia_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Yelp",
           fluidRow( 
             plotOutput('yelp_stage3_facet'),
             downloadBttn("yelp_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Amazon",
           fluidRow(   
             plotOutput('amazon_stage3_facet'),
             downloadBttn("amazon_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("Customer",
           fluidRow(  
             plotOutput('customer_stage3_facet'),
             downloadBttn("customer_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )))


######  facet_dta tabBox ####################

tb_stage3_facet_data = tabBox(
  title = "Models",
  # The id lets us use input$id on the server to find the current tab
  id = "tabset_stage3_facet_data", 
  width = 12,
  tabPanel("BERT",
           fluidRow(   
             plotOutput('bert_stage3_facet_data')),
           downloadBttn("BERT_button_stage3", "Download", style = 'unite', size = 'sm')
           
  ),
  
  tabPanel("RandomForest",
           fluidRow(   
             plotOutput('rf_stage3_facet_data'),
             downloadBttn("RandomForest_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("NaiveBayes",
           fluidRow( 
             plotOutput('nb_stage3_facet_data'),
             downloadBttn("NaiveBayes_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("LinearSVC",
           fluidRow(   
             plotOutput('linearsvc_stage3_facet_data'),
             downloadBttn("LinearSVC_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("LogisticRegression",
           fluidRow(  
             plotOutput('logisticregression_stage3_facet_data'),
             downloadBttn("LogisticRegression_button_stage3", "Download", 
                          style = 'unite', size = 'sm')
           )))
########################################################
########################################################








########################################################
############## Server functions ########################
#########################################################

plot_stage3_facet_model = function(ds_name) {
  
  data_all %>%
    filter(dataset == ds_name) %>%
    filter(training_size != 10000) %>%
    ggplot(aes(x = training_size, y =accuracy, color = class_num ))+
    geom_boxplot()+
    stat_summary(fun=mean, geom="smooth", 
                 aes(group= class_num),lwd=0.5, alpha = 0.5)+
    theme_bw()+
    academic_theme+
    facet_grid(~ model_name)+
    theme(axis.title.x=element_blank(),
          axis.text.x = element_text(size = 10))+
    labs(color = 'Class name')+
    scale_fill_Publication()+
    # scale_fill_grey()+
    scale_colour_Publication()+
    theme(legend.position = "bottom")
}


## facet by datasets function

plot_stage3_facet_data = function(modelname) {
  
  data_all %>%
    filter(model_name == modelname) %>%
    filter(training_size != 10000) %>%
    ggplot(aes(x = training_size, y =accuracy, color = class_num ))+
    geom_boxplot()+
    stat_summary(fun=mean, geom="smooth", 
                 aes(group= class_num),lwd=0.5, alpha = 0.5)+
    theme_bw()+
    academic_theme+
    facet_grid(~ dataset)+
    theme(axis.title.x=element_blank(),
          axis.text.x = element_text(size = 10))+
    labs(color = 'Class name')+
    scale_colour_viridis_d()+
    theme(legend.position = "bottom")

}

