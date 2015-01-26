# Load data table library to allow bindlist and other data frame/table functions
library("data.table")
library(plyr)

#1 Merges the training and the test sets to create one data set.
test_human_activity_ds <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/test/X_test.txt"
train_human_activity_ds <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/train/X_train.txt"
feature_name <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/features.txt"

listset <- list()
listset[[1]] = read.table(test_human_activity_ds)
listset[[2]] = read.table(train_human_activity_ds)

mergedata = merge( listset[[1]] , listset[[2]] , all=TRUE )

#2 Extracts only the measurements on the mean and standard deviation for each measurement. 
featuredata <- read.table(feature_name)
colNb = 0 
newcolumns <- ""

# Looping on all the features / column name
for (ii in 1:length( featuredata[[1]]  ) ) {
  if ( grepl( "mean", as.character( featuredata[[ii,2]] ) ) == TRUE ) { 
    colNb = colNb + 1 
    newcolumns[colNb] <- as.character( featuredata[[ii,2]] )
  }
  if ( grepl( "std", as.character( featuredata[[ii,2]] ) ) == TRUE ) {
    colNb = colNb + 1 
    newcolumns[colNb] <- as.character( featuredata[[ii,2]] )
  }
}

rowNb <- nrow(mergedata)
m <- as.data.frame(matrix(0, ncol = colNb+2 , nrow = rowNb ) )
newcolumns[colNb+1] <- "subject"
newcolumns[colNb+2] <- "activity"

m <- setnames( m , newcolumns )
colNb = 0  
for (ii in 1:length( featuredata[[1]]  ) ) {
  if ( grepl( "mean", as.character( featuredata[[ii,2]] ) ) == TRUE ) { 
    colNb = colNb + 1 
    m[,colNb] <- mergedata[,ii]
  }
  if ( grepl( "std", as.character( featuredata[[ii,2]] ) ) == TRUE ) {
    colNb = colNb + 1
    m[,colNb] <- mergedata[,ii]
  }
}

#3 Header/labels used is directly coming from the feature file

#5 From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

# Adding the subject 
train_subject_ds <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/train/subject_train.txt"
test_subject_ds <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/test/subject_test.txt"
listset <- list()
listset[[1]] = read.table(train_subject_ds)
listset[[2]] = read.table(test_subject_ds)

allsubject <- as.data.frame(matrix(0, ncol = 1 , nrow = nrow(m) ) )
allsubject = merge( listset[[1]] , listset[[2]] , all=TRUE )
colNb=colNb+1
m[,colNb] <- allsubject[,1]

# Adding activities
train_y_ds <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/train/y_train.txt"
test_y_ds <- "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/test/y_test.txt"
tr_y = read.table(train_y_ds)
te_y = read.table(test_y_ds)

ally <- as.data.frame(matrix(0, ncol = 1 , nrow = nrow(m) ) )
ally = merge( tr_y[1] , te_y[1] )
colNb=colNb+1
m[,colNb] <- ally[,1]

write.csv(m, file= "/Users/bdolimier/developer/perso/classDS/data/UCI_HAR_Dataset/result_UCI.txt", fileEncoding = "macroman")
