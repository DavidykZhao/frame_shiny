## This is the Introduction page for the visualization project
# This is the fluidRow object embedded into the tabItems --> tabItem. 

intro_fluidrow = fluidRow(
                column(12, 
                        # img(src='nlp_pic.jpeg', align = "right", 
                        # style =  "witdh: 2000; height: 120; max-width: 100%; height: auto;
                        #   display: block; margin-top: auto; margin-bottom: auto;",
                        # class = 'hero-image'),
                       HTML({
                         '<section class="hero">
                            <div class="hero-inner">
                               <h1>Deep learning for textual classification</h1>
                               <h2>Transfer learning for NLP classification under small training size</h2>
                           </div>
                           </section> 
                         '}),
                       

                        br()),
  
  
                column(8, offset = 2,

                                 
                h1("Welcome"),
                br(),

                p("This is a project to visualize the simulation results from 
                            different machine learning and deep learning models' performances on
                            textual classification"),
               
                br(),
                h1('motivation'),
                br(),
                p("Even though transfer learning NLP models have pushed the boundary and
                  break the SOTA (State-of-the-Art) records in multiple NLP tasks, little is knowns about 
                  their performances under small training sizes; especially, little research has shown the stability of the models' performances"),
                
                p(paste("Thus, this research run", nrow(data_all),"experiments/simulations to showcase the performances
                        of deep learning and machine learning models on textual classification.")),
                
                p("Further, this study adopts the most representative transfer learning models: BERT (Bidirectional Encoder Representations from Transformers) and 
                  XLNet (Generalized Autoregressive Pretraining for Language Understanding) and contrast them to the traditional bag-of-words approach utilized in machine learning models "),
                br(),
                
              
                
                
                h1("The experiments"),
                
                h3("Dataset"),
                p("There are in total of 5 datasets. These datasets were chosen because they
                  are either the benchmark datasets NLP researcher use, or the common daaset practitioners use.
                  These datasets and their corresponding information are provided below:"),
                DT::dataTableOutput("data_infotable"),
                
                
                
                br(),
              
                p(paste("The", nrow(data_all), "experiments could be collapsed into 3 stages:")),
                
                tags$ol(
                  tags$li("Stage 1: The marginal accuracy of different models across different datasets"), 
                  tags$li("Stage 2: The accuracy of different models as training size grows across different datasets"), 
                  tags$li("Stage 2: The accuracy of different models as training size grows with different number of classes across different datasets")
                ), # closing the tags$ol obj
                
                h3('Stage 1 information'), 
                p("In stage 1, the models were run across datasets at a relative large datasize (10000). In this stage,
                the goal is to investigate the marginal performance of those models and compare them to the current SOTA results.
                  "),
                p("For each machine learning models, 10 simulations were run for each dataset; for each deep learning models, 
                  5 simulations were run for each dataset. See table below"),
                DT::dataTableOutput("stage1_table" ),
                
                h3('Stage 2 information'), 
                
                
                
                
                
                
                
))