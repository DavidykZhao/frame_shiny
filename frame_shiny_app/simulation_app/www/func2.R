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
########################################################
########################################################








########################################################
############## Server functions ########################
#########################################################
#agnews_stage2_facet


plot_stage2_facet_model = function(ds_name) {
  
  data_all %>%
    filter(dataset == ds_name) %>%
    ggplot(aes(x = training_size, y = accuracy)) +
    #stat_boxplot(geom="errorbar", width=.5)+
    geom_boxplot()+
    stat_summary(fun=mean, geom="smooth", 
                 aes(group= model_name),lwd=0.5, alpha = 0.5)+
    labs(paste(title = 'Performances of models as training size grows for', model))+
    theme_bw()+
    academic_theme+
    scale_fill_Publication()+
    # scale_fill_grey()+
    scale_colour_Publication()+
    theme(legend.text = element_text(size=10),
          legend.key.size = unit(1, "lines"),
          legend.position = c(0.8, 0.15))+
    facet_grid(~ model_name)
}


