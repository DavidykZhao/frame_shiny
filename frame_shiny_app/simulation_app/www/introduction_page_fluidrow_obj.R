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

                p("This is a project to visualize the simulation results from 
                            different machine learning and deep learning models' performances on
                            textual classification"),
                
                h1('motivation')
                
                p("Even though transfer learning NLP models have pushed the boundary and
                  break the SOTA (State-of-the-Art) records in multiple NLP tasks, little is knowns about 
                  their performances under small training sizes; especially, little research has shown the stability of the models' performances"),
                
                p(paste("Thus, this research run", nrow(data_all),"experiments/simulations to showcase the performances
                        of deep learning and machine learning models on textual classification.")),
                
                p("Further, this study adopts the most representative transfer learning models: BERT (Bidirectional Encoder Representations from Transformers) and 
                  XLNet (Generalized Autoregressive Pretraining for Language Understanding) and contrast them to the traditional bag-of-words approach utilized in machine learning models "),
                
                h1("The experiments/simulations"),
              
                p(paste("There are three stages for those", nrow(data_all), "experiments:")),
                
                tags$ol(
                  tags$li("Stage 1: The marginal accuracy of different models across different datasets"), 
                  tags$li("Stage 2: The accuracy of different models as training size grows across different datasets"), 
                  tags$li("Stage 2: The accuracy of different models as training size grows with different number of classes across different datasets")
                ) # closing the tags$ol obj
                
                
                  
                
                
                
                
))