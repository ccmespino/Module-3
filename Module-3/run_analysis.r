library(plyr)

#IMPORT DATASETS#
x_train = read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/train/X_train.txt")
y_train = read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/train/y_train.txt")
x_test = read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/test/X_test.txt")
y_test = read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/test/y_test.txt")
subject_train = read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/train/subject_train.txt")
subject_test = read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/test/subject_test.txt")

#Merging#
x = rbind(x_train,x_test)
y = rbind(y_train,y_test)
subj = rbind(subject_train,subject_test)


#Extract mean and sd only from features#
features <- read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/features.txt")
mean_n_std <- grep(".*mean.*|.*std.*", features[, 2])
x <- x[,mean_n_std]
names(x) <- features[mean_n_std, 2]

#Load activities and labels#
activities <- read.table("C:/Users/Cel Espino/Desktop/Coursera/UCI HAR Dataset/activity_labels.txt")
y[, 1] <- activities[y[, 1], 2]
names(y) <- "activity"
names(subj) <- "subject"

#Final Data#
data_0 <- cbind(x, y, subj)
data <- ddply(data_0, .(subject, activity), function(x) colMeans(x[, 1:66]))
write.table(data, "tidy.txt", row.names=FALSE)