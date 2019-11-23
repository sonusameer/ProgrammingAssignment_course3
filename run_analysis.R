###############################################################
##                                                           ##
## Course project for Course 3 - Getting and Cleaning Data   ##
##                                                           ##
###############################################################

library(tidyverse)
library(data.table)
library(dplyr)

##Data description from here:
#http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones

##Set appropriate path.
setwd('/home/sara/Work/Courses/Coursera/Data_Science_Specialization/Course3/Course_Project/UCI_HAR_Dataset/')

##Setting the main path for the dataset.
main_path <- "/home/sara/Work/Courses/Coursera/Data_Science_Specialization/Course3/Course_Project/UCI_HAR_Dataset"

##Reading datasets.
subject_train = read.table(paste0(main_path, '/train/subject_train.txt'),header=FALSE)
x_train = read.table(paste0(main_path, '/train/x_train.txt'),header=FALSE)
y_train = read.table(paste0(main_path, '/train/y_train.txt'),header=FALSE)
subject_test = read.table(paste0(main_path, '/test/subject_test.txt'),header=FALSE)
x_test = read.table(paste0(main_path, '/test/x_test.txt'),header=FALSE)
y_test = read.table(paste0(main_path, '/test/y_test.txt'),header=FALSE)

##Combining datasets. 
x_dataset <- rbind(x_train, x_test)
y_dataset <- rbind(y_train, y_test)
subject_dataset <- rbind(subject_train, subject_test)

##Extracting mean and std values.

##Extracting the columns that have the mean and std measurements. 
x_dataset_mean_std <- x_dataset[, grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])]
  
##Extracting the names for the columns in the dataset.
col_numbers <- grep("-(mean|std)\\(\\)", read.table("features.txt")[, 2])
names(x_dataset_mean_std) <- read.table("features.txt")[col_numbers, 2] 

#print(y_dataset[,1])
##Setting the first column in the dataset to the legible activity label.
y_dataset[, 1] <- read.table("activity_labels.txt")[y_dataset[, 1], 2]

##Setting the name for the first column to "Activity" (one of the 6 listed activities).
names(y_dataset) <- "Activity"

##Setting the name for the subject to "Subject".
names(subject_dataset) <- "Subject"

##Organizing datasets into one single tidy dataset.

##Binding all three datasets by column.
single_dataset <- cbind(x_dataset_mean_std, y_dataset, subject_dataset)

##Setting descriptive names for all variab  les.

##Making syntactically valid names.
names(single_dataset) <- make.names(names(single_dataset))

##Substituting less descriptive names by apt ones.
names(single_dataset) <- gsub('Acc',"Acceleration",names(single_dataset))
names(single_dataset) <- gsub('GyroJerk',"AngularAcceleration",names(single_dataset))
names(single_dataset) <- gsub('Gyro',"AngularSpeed",names(single_dataset))
names(single_dataset) <- gsub('Mag',"Magnitude",names(single_dataset))
names(single_dataset) <- gsub('^t',"TimeDomain.",names(single_dataset))
names(single_dataset) <- gsub('^f',"FrequencyDomain.",names(single_dataset))
names(single_dataset) <- gsub('\\.mean',".Mean",names(single_dataset))
names(single_dataset) <- gsub('\\.std',".StandardDeviation",names(single_dataset))
names(single_dataset) <- gsub('Freq\\.',"Frequency.",names(single_dataset))
names(single_dataset) <- gsub('Freq$',"Frequency",names(single_dataset))

##Aggregate and order dataset.

##Splitting the dataset.
data_2<-aggregate(. ~Subject + Activity, single_dataset, mean)
##Ordering the dataset.
data_2<-data_2[order(data_2$Subject,data_2$Activity),]
##Writing the tidy data to file.
write.table(data_2, file = "new_tidy_data.txt",row.name=FALSE)
