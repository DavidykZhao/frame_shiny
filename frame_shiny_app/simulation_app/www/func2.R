#######       functions for stage 2   ##########
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
tb_stage2_facet_model = tabBox(
  title = "Datasets",
  # The id lets us use input$id on the server to find the current tab
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


######  facet_dta tabBox

tb_stage2_facet_data = tabBox(
  title = "Models",
  # The id lets us use input$id on the server to find the current tab
  id = "tabset_stage2_facet_data", 
  width = 12,
  tabPanel("BERT",
           fluidRow(   
             plotOutput('bert_stage2_facet_data')),
           downloadBttn("BERT_button_stage2", "Download", style = 'unite', size = 'sm')
           
  ),
  
  tabPanel("RandomForest",
           fluidRow(   
             plotOutput('rf_stage2_facet_data'),
             downloadBttn("RandomForest_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("NaiveBayes",
           fluidRow( 
             plotOutput('nb_stage2_facet_data'),
             downloadBttn("NaiveBayes_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("LinearSVC",
           fluidRow(   
             plotOutput('linearsvc_stage2_facet_data'),
             downloadBttn("LinearSVC_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )),
  
  tabPanel("LogisticRegression",
           fluidRow(  
             plotOutput('logisticregression_stage2_facet_data'),
             downloadBttn("LogisticRegression_button_stage2", "Download", 
                          style = 'unite', size = 'sm')
           )))
########################################################
########################################################








########################################################
############## Server functions ########################
#########################################################

plot_stage2_facet_model = function(ds_name) {
  
  data_all %>%
    filter(stage == 'stage2') %>%
    filter(dataset == ds_name) %>%
    ggplot(aes(x = training_size, y = accuracy)) +
    #stat_boxplot(geom="errorbar", width=.5)+
    geom_boxplot()+
    stat_summary(fun=mean, geom="smooth", 
                 aes(group= model_name),lwd=0.5, alpha = 0.5)+
    theme_bw()+
    academic_theme+
    scale_fill_Publication()+
    # scale_fill_grey()+
    scale_colour_Publication()+
    theme(legend.text = element_text(size=10),
          legend.key.size = unit(1, "lines"),
          legend.position = c(0.8, 0.15))+
    facet_grid(~ model_name)+
    labs(title = paste('Performances of models as training size grows for', ds_name, 'dataset'))
}


## facet by datasets function

plot_stage2_facet_data = function(modelname) {
  
  data_all %>%
    filter(stage == 'stage2') %>%
    filter(model_name == modelname) %>%
    ggplot(aes(x = training_size, y = accuracy)) +
    #stat_boxplot(geom="errorbar", width=.5)+
    geom_boxplot()+
    stat_summary(fun=mean, geom="smooth", 
                 aes(group= dataset),lwd=0.5, alpha = 0.5)+
    theme_bw()+
    academic_theme+
    scale_fill_Publication()+
    # scale_fill_grey()+
    scale_colour_Publication()+
    theme(legend.text = element_text(size=10),
          legend.key.size = unit(1, "lines"),
          legend.position = c(0.8, 0.15))+
    facet_grid(~ dataset)+
    labs(title = paste('Performances of', modelname, 'as training size grows'))
}

