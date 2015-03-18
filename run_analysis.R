#url - path to UCI HAR Dataset folder, for instance "~/data/UCI HAR Dataset/"
run_analysis <- function(url) {
  
  #reading activity labels and feature names
  activity_labels <- read.table(paste(url, "activity_labels.txt", sep=""), stringsAsFactors=FALSE)
  features <- read.table(paste(url, "features.txt", sep=""), stringsAsFactors=FALSE)
  
  #reading test and train X data and merging them into one frame
  #also naming columns after the features table
  x <- rbind(read.table(paste(url, "test/X_test.txt", sep=""),
                        col.names=features[,2]),
             read.table(paste(url, "train/X_train.txt", sep=""),
                        col.names=features[,2]))
  
  #reading test and train Y data and merging them into one frame 
  y <- rbind(read.table(paste(url, "test/y_test.txt", sep="")),
             read.table(paste(url, "train/y_train.txt", sep="")))
  
  #reading test and train subject data and merging them into one frame
  subject <- rbind(read.table(paste(url, "test/subject_test.txt", sep="")),
                   read.table(paste(url, "train/subject_train.txt", sep="")))
  
  #extracting only the measurements on the mean and standard deviation for each measurement
  x <- x[,grepl("mean()", features[,2], fixed=TRUE) | grepl("std()", features[,2], fixed=TRUE)]
  
  #attaching activity name to each measurement
  library(dplyr)
  x <- cbind(x, y)
  x <- left_join(x, activity_labels)
  x[,"V1"] <- NULL
  x <- rename(x, activity = V2)
  
  #attaching subject number to each measurement
  x <- cbind(x, subject=subject[,1])
  
  #reshaping the data according to Step 5 in the assignment
  x <- group_by(x, subject, activity)
  x <- mutate_each(x, funs(mean))
  x <- unique(x)
  
  write.table(x, file = "tidyData.txt", row.names = FALSE)
}