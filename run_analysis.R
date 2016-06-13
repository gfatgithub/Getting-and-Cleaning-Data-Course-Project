
##Create data folder
if(!file.exists("./data")){dir.create("./data")}

##Loading the zip file
zipURL="https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip"
destFile ="./data/Dataset.zip"
download.file(zipURL,destFile)

##Unzip the data file
unzip(destFile,exdir="./data")

## creating test data 
X_test<- read.table("./data/UCI HAR Dataset/test/X_test.txt")
Y_test<- read.table("./data/UCI HAR Dataset/test/Y_test.txt")
subject_test <-read.table("./data/UCI HAR Dataset/test/subject_test.txt")
dim(X_test)
dim(Y_test)
dim(subject_test)

## creating training data:
X_train<- read.table("./data/UCI HAR Dataset/train/X_train.txt")
Y_train<- read.table("./data/UCI HAR Dataset/train/Y_train.txt")
subject_train <-read.table("./data/UCI HAR Dataset/train/subject_train.txt")
dim(X_train)
dim(Y_train)
dim(subject_train)

## features and activity
features<-read.table("./data/UCI HAR Dataset/features.txt")
activity_labels<-read.table("./data/UCI HAR Dataset/activity_labels.txt")
dim(features)
dim(activity_labels)

##Merges the training and the test sets to create one data set.
X<-rbind(X_test, X_train)
Y<-rbind(Y_test, Y_train)
Subject<-rbind(subject_test, subject_train)
dim(X)
dim(Y)
dim(Subject)


##Extracts only the measurements on the mean and standard deviation for each measurement
index<-grep("mean\\(\\)|std\\(\\)", features[,2]) 
X<-X[,index]


##Uses descriptive activity names to name the activities in the data set
Y[,1]<-activity_labels[Y[,1],2] 


##Appropriately labels the data set with descriptive variable names
names(X)<-features[index,2] 
names(Subject)<-"SubjectID"
names(Y)<-"Activity"

readyData<-cbind(Subject, Y, X)

##From the data set in step 4, creates a second, independent tidy data set with the average of each variable for each activity and each subject.

readyData<-data.table(readyData)
tidyData <- readyData[, lapply(.SD, mean), by = 'SubjectID,Activity'] 
dim(TidyData)
write.table(tidyData, file = "tidy.txt", row.names = FALSE)


#END
