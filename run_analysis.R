run_analysis <- function(export=TRUE){
  #load reshape2 library
  library(reshape2)
  
  print("Starting to import data...")
  # load data from working directory
  X_test <- read.table("./UCI HAR Dataset/test/X_test.txt", quote="\"")
  print("Test data imported")
  
  X_train <- read.table("./UCI HAR Dataset/train/X_train.txt", quote="\"")
  print("Train data imported")
  
  y_test <- read.table("./UCI HAR Dataset/test/y_test.txt", quote="\"")
  y_train <- read.table("./UCI HAR Dataset/train/y_train.txt", quote="\"")
  
  subject_test <- read.table("./UCI HAR Dataset/test/subject_test.txt", quote="\"")
  subject_train <- read.table("./UCI HAR Dataset/train/subject_train.txt", quote="\"")
  
  features <- read.table("./UCI HAR Dataset/features.txt", quote="\"")
  activity_labels <- read.table("./UCI HAR Dataset/activity_labels.txt", quote="\"")
  
  print("All data imported")
  
  # merge data sets
  data <- rbind(X_train, X_test)
  activities <- rbind(y_train, y_test)
  subjects <- rbind(subject_train, subject_test)
  
  # remove unnecessary data sets
  rm("X_train","X_test","y_train","y_test","subject_train","subject_test")
  
  # convert activities from numbers to strings
  activities <- lapply(activities, function(x){out <- activity_labels$V2[x]})
  rm(activity_labels)
  
  # filter columns that contain "mean()" or "std()" and name them
  filt <- grepl("mean()" ,features$V2, fixed = TRUE) | grepl("std()" ,features$V2, fixed = TRUE)
  data <- data[,filt]
  colnames(data) <- t(features$V2)[filt]
  
  data <- cbind(subjects,activities,data)
  colnames(data)[1] <- "subjects"
  colnames(data)[2] <- "activities"
  
  rm(features,subjects)
  
  # order data according to subjects and activities
  data <- data[order(data$subjects,data$activities),]
  
  # melt data
  meltData <- melt(data, id=c("subjects","activities"))
  
  # cast data
  tidyData <- dcast(meltData, subjects + activities ~ ..., mean)
  
  rm(data,meltData,activities,filt)
  # write data to tab-separated txt file if export == TRUe
  if(export){
    print("Writing tidy data to ./tidyData.txt")
    write.table(tidyData, file="./tidyData.txt", sep="\t", row.names=FALSE)
  }
  print("Tidy data produced - end of script :)")
  return(tidyData)
}