# phoneActivityAnal
Human Activity as recorded by smart phone analysis

- Data source is : http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones#

- using R software with library data.table and plyr 

- Load data table library to allow bindlist and other data frame/table functions

- Training and test pre-processed data is merged into one dataset

- Dataset is then subsetted to extract only mean and standard deviation data

- Dataset name and labels correspond to set of attributes found in features.txt from  provide source data

- Average and mean by subject, by activity and by activity/subject were computed

- Result saved in this repo under result_UCI.txt
