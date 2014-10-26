library(dplyr)
library(tidyr)
library(reshape2)

## Assume that the "getdata-projectfiles-UCI HAR Dataset.zip" has been unzipped into the current working directory
## 1: Read in the files
features <- read.csv("./UCI HAR Dataset/features.txt",header=FALSE,sep=" ", stringsAsFactors=FALSE)
activity_labels <- read.csv("./UCI HAR Dataset/activity_labels.txt",header=FALSE, sep=" ",stringsAsFactors=FALSE)
y_test <- read.csv("./UCI HAR Dataset/test/y_test.txt",header=FALSE, sep=" ")
x_test <- read.csv("./UCI HAR Dataset/test/X_test.txt", header=FALSE, sep="")
subject_test <- read.csv("./UCI HAR Dataset/test/subject_test.txt",header=FALSE, sep = " ")
y_train <- read.csv("./UCI HAR Dataset/train/y_train.txt",header=FALSE, sep=" ")
x_train <- read.csv("./UCI HAR Dataset/train/X_train.txt", header=FALSE, sep="")
subject_train <- read.csv("./UCI HAR Dataset/train/subject_train.txt",header=FALSE, sep = " ")

## 2: Give each of the data meaningful column names easier to understand code later on
colnames(activity_labels) <- c("activity", "activityDesc")
## x data is the actual data where the column names are defined in features.txt
colnames(x_test) <- features$V2
colnames(x_train) <- features$V2
## y data is the activity that correspond to each observation in x
colnames(y_test) <- c("activity")
colnames(y_train) <- c("activity")
## subject data refers to the subject that correspond to each observation in x
colnames(subject_test) <- c("subject")
colnames(subject_train) <- c("subject")

## 3: Merge the datasets together
## 3.1: Clip the test data together
activityDataTest <- cbind(x_test,y_test)
subjectActivityDataTest <- cbind(activityDataTest,subject_test)
## 3.2: Clip the train data together
activityDataTrain <- cbind(x_train,y_train)
subjectActivityDataTrain <- cbind(activityDataTrain,subject_train)
## 3.3: Clib the test and training data together
subjectActivityData <- rbind(subjectActivityDataTest, subjectActivityDataTrain)

## 4: Clean up the intermediate datasets to release some memory
rm(x_test)
rm(y_test)
rm(subject_test)
rm(activityDataTest)
rm(subjectActivityDataTest)
rm(x_train)
rm(y_train)
rm(subject_train)
rm(activityDataTrain)
rm(subjectActivityDataTrain)

## 5: Extract only the measurements on the mean and standard deviation for each measurement
## Only those features with the word (including parenthesis) mean() and std() are included
## 5.1: Get a list of the features that meet the above criteria
selectedFeatures <- filter(features, grepl("mean\\(\\)",V2) | grepl("std\\(\\)",V2))
## 5.2: Create a vector of all columns to extract, including the activity/subject column already clipped on earlier
columnsToSelect <- c("activity","subject",selectedFeatures$V2)
## 5.3: Extract only the mean and standard deviation of each measurements
selectedActivityMeasurements <- subjectActivityData[,columnsToSelect]

## 6: Use descriptive activity names for the observations in the extracted data set
selectedActivityMeasurements$activity <- activity_labels[match(selectedActivityMeasurements$activity,activity_labels$activity),2]

## 7: Create a tidy data set with the average of each variable for each activity/subject
## 7.1: Melt the data into a long data sets, using the activity/subject as the id column
meltedData <- melt(selectedActivityMeasurements, id=c("activity","subject"))
## 7.2: Group the melted data by activity/subject and the measurement type and calculate the average
averageMeasurement <- meltedData %>%
                      group_by(activity,subject,variable) %>%
                      summarise(averageValue = mean(value))

## 8: Tidy the data in the variable column into a more readable form
## 8.1: - becomes space
averageMeasurement$variable <- gsub("-"," ", averageMeasurement$variable)
## 8.2:  mean() becomes mean
averageMeasurement$variable <- gsub("mean\\(\\)","mean", averageMeasurement$variable)
## 8.3: std() becomes standard deviation
averageMeasurement$variable <- gsub("std\\(\\)","standard deviation", averageMeasurement$variable)
## 8.4: first letter t becomes time
averageMeasurement$variable <- gsub("^t","time ", averageMeasurement$variable)
## 8.5: first letter f becomes frequency
averageMeasurement$variable <- gsub("^f","frequency ", averageMeasurement$variable)
## 8.6: Acc becomes accelerometer
averageMeasurement$variable <- gsub("Acc"," accelerometer ", averageMeasurement$variable)
## 8.7: Gyro becomes gyroscope
averageMeasurement$variable <- gsub("Gyro"," gyroscope ", averageMeasurement$variable)
## 8.8: Mag becomes magnitude
averageMeasurement$variable <- gsub("Mag"," magnitude ", averageMeasurement$variable)
## 8.9: Body becomes body
averageMeasurement$variable <- gsub("Body","body", averageMeasurement$variable)
## 8.10: Gravity becomes gravity
averageMeasurement$variable <- gsub("Gravity","gravity", averageMeasurement$variable)
## 8.11: Jerk becomes jerk
averageMeasurement$variable <- gsub("Jerk","jerk", averageMeasurement$variable)
## 8.12: Removed the duplicate 'body'
averageMeasurement$variable <- gsub("bodybody","body", averageMeasurement$variable)

## 9: Write the data to a text file
write.table(averageMeasurement, file="tidydata.txt", row.name=FALSE)

## 10: Final clean up of all data files
rm(features)
rm(activity_labels)
rm(averageMeasurement)
rm(meltedData)
rm(columnsToSelect)
rm(selectedFeatures)
rm(selectedActivityMeasurements)
rm(subjectActivityData)
