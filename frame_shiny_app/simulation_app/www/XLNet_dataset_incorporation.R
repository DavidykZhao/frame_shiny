## This is the script to incorporate the XLNet model resuts in to the data_all ds
################################################################################
library(tidyverse)

data_all_prior = read.csv('./www/all_stages.csv')
data_all_prior$training_size = as.factor(data_all_prior$training_size)
data_all_prior$class_num = as.factor(data_all_prior$class_num)


head(data_all_prior)


####################### read in stage1 files ###########################
xlnet_stage1_dbpedia = read.csv('./www/XLNet_data/stage1/xlnet_dbpedia_accu_5.csv')
xlnet_stage1_yelp = read.csv('./www/XLNet_data/stage1/xlnet_yelp_accu_5.csv')
xlnet_stage1_amazon = read.csv('./www/XLNet_data/stage1/xlnet_amazon_accu_5.csv')
xlnet_stage1_agnews = read.csv('./www/XLNet_data/stage1/xlnet_agnews_accu_5.csv')

xlnet_stage1 = rbind(xlnet_stage1_dbpedia,
                     xlnet_stage1_yelp,
                     xlnet_stage1_amazon,
                     xlnet_stage1_agnews)

xlnet_stage1$training_size = 10000
xlnet_stage1$stage = "stage1"
xlnet_stage1$dataset = c(rep("dbpedia", 5),
                         rep("yelp", 5),
                         rep("amazon", 5),
                         rep("agnews", 5))

xlnet_stage1$class_num = c(rep(13, 5),
                           rep(5, 5),
                           rep(5, 5),
                           rep(4, 5))



####################### read in stage2 files ###########################
xlnet_stage2_yelp = read.csv('./www/XLNet_data/stage2/xlnet_stage2_yelp_adjusted.csv')
xlnet_stage2_amazon = read.csv('./www/XLNet_data/stage2/xlnet_stage2_amazon_adjusted.csv')
xlnet_stage2_agnews = read.csv('./www/XLNet_data/stage2/xlnet_stage2_agnews_adjusted.csv')
xlnet_stage2_dbpedia = read.csv('./www/XLNet_data/stage2/xlnet_stage2_dbpedia_adjusted.csv')  


xlnet_stage2 = rbind(xlnet_stage2_dbpedia,
                     xlnet_stage2_yelp,
                     xlnet_stage2_amazon,
                     xlnet_stage2_agnews)

xlnet_stage2$stage = "stage2"
xlnet_stage2$dataset = c(rep("dbpedia", 35), 
                         rep("yelp", 35),
                         rep("amazon", 35),
                         rep("agnews", 35)
                         )

xlnet_stage2$class_num = c(
                           rep(13, 35),
                           rep(5, 35),
                           rep(5, 35),
                           rep(4, 35))

dim(xlnet_stage2) # 140 * 6

####################### read in stage3 files ###########################

xlnet_stage3_yelp = read.csv('./www/XLNet_data/stage3/xlnet_stage3_yelp.csv')
xlnet_stage3_yelp$class_num = 3
xlnet_stage3_amazon = read.csv('./www/XLNet_data/stage3/xlnet_stage3_amazon.csv')
xlnet_stage3_amazon$class_num = 3
xlnet_stage3_dbpedia = read.csv('./www/XLNet_data/stage3/xlnet_stage3_dbpedia.csv')
xlnet_stage3_dbpedia$class_num = 5

xlnet_stage3 = rbind(xlnet_stage3_dbpedia,
                     xlnet_stage3_yelp,
                     xlnet_stage3_amazon)

xlnet_stage3$dataset = c(rep("dbpedia", 35),
                         rep("yelp", 35),
                         rep("amazon", 35))
xlnet_stage3$stage = "stage3"
dim(xlnet_stage3)  # 105 * 6



xlnet_data = rbind(xlnet_stage1,
                   xlnet_stage2,
                   xlnet_stage3)


###################### fix the Customer stage 1 and stage 2
# remove the original stage 1 and stage2 for the customer data
data_tobe_removed = data_all_prior %>%
  filter(model_name == "BERT" & dataset == "customer" & stage %in% c("stage1", "stage2")) 
dim(data_all_prior)   # 2276 * 6
data_all_prior = anti_join(data_all_prior, data_tobe_removed)

data_customer_stage1_stage2 = read.csv('./www/XLNet_data/bert_stage2_customer_adjusted.csv')
head(data_customer_stage1_stage2)
data_customer_stage1_stage2$stage = c(rep("stage2", 35),
                                      rep("stage1", 5))
data_customer_stage1_stage2$class_num = 13
data_customer_stage1_stage2$dataset = "customer"
dim(data_customer_stage1_stage2)


#### rbind fixed customer stage1&2, XLNet data and data_all_prior tgther
## fixed the number of class_nums in stage1 & 2
data_all_prior[data_all_prior$dataset == "customer" & 
                 data_all_prior$stage %in% c("stage1", "stage2"), 4] = 13

data_all_final = rbind(data_all_prior, data_customer_stage1_stage2, xlnet_data)
# fixed the model name from xlnet to XLNET
data_all_final$model_name = as.character(data_all_final$model_name)
data_all_final[data_all_final$model_name == "xlnet", 1 ] = "XLNET"
data_all_final$model_name = as.factor(data_all_final$model_name)

data_all_final %>%
  filter(model_name == "XLNET")


write.csv(data_all_final, file = "all_stages2.csv", row.names = F)


data_all_final %>%
  filter(dataset == "agnews" & stage == "stage2" & model_name == "XLNET")

dim(data_all_final)


