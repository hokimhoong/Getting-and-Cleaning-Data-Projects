#########################################################################################
#
# Step1. Merges the training and the test sets to create one data set.
#
#########################################################################################

#setwd("C:/project/")

# read X_train.txt content
trainInfo <- read.table("data/train/X_train.txt")
# sets the dimension of trainInfo
dim(trainInfo) 


################## Set Train Info ##################

# read y_train.txt content
trainY <- read.table("data/train/y_train.txt")
# creates tabular results of trainY
table(trainY)

# read subject_train.txt content
trainSubject <- read.table("data/train/subject_train.txt")


################## Set Test Info ##################

# read y_test.txt content
testY <- read.table("data/test/y_test.txt") 
# creates tabular results of trainY
table(testY) 

# read X_test.txt content
testX <- read.table("data/test/X_test.txt")
# sets the dimension of testX
dim(testX) 

# read subject_test.txt content
testSubject <- read.table("data/test/subject_test.txt")

################## Merge Train and Test Info ##################

# merge rows 
joinInfo <- rbind(trainInfo, testX)
# sets the dimension of joinInfo
dim(joinInfo) 

# merge rows 
joinY <- rbind(trainY, testY)
# sets the dimension of joinY
dim(joinY) 

# merge rows 
joinSubject <- rbind(trainSubject, testSubject)
# sets the dimension of joinSubject
dim(joinSubject) 


#########################################################################################
# 
#Step2. Extracts only the measurements on the mean and standard deviation for each measurement. 
#
#########################################################################################

# read features.txt content
features <- read.table("data/features.txt")
# sets the dimension of features
dim(features)  
meanStdIndices <- grep("mean\\(\\)|std\\(\\)", features[, 2])
length(meanStdIndices) 
joinInfo <- joinInfo[, meanStdIndices]
dim(joinInfo) 

names(joinInfo) <- gsub("\\(\\)", "", features[meanStdIndices, 2])
names(joinInfo) <- gsub("-", "", names(joinInfo)) 
names(joinInfo)

#########################################################################################
# 
# Step3. Uses descriptive activity names to name the activities in the data set
#
#########################################################################################

# read activity_labels.txt content
activity <- read.table("data/activity_labels.txt")
activity[, 2] <- tolower(gsub("_", "", activity[, 2]))
substr(activity[2, 2], 8, 8) <- toupper(substr(activity[2, 2], 8, 8))
substr(activity[3, 2], 8, 8) <- toupper(substr(activity[3, 2], 8, 8))
activityLabel <- activity[joinY[, 1], 2]
joinY[, 1] <- activityLabel
names(joinY) <- "activity"
names(joinY)

#########################################################################################
# 
# Step4. Appropriately labels the data set with descriptive activity names. 
#
#########################################################################################

names(joinSubject) <- "subject"
tempData <- cbind(joinSubject, joinLabel, joinInfo)
dim(tempData) 
write.table(tempData, "merged-data.txt") # write out the 1st dataset

#########################################################################################
# 
# Step5. Creates a second, independent tidy data set with the average of each variable for 
# each activity and each subject. 
#
#########################################################################################

subLen <- length(table(joinSubject)) 
actLen <- dim(activity)[1] 
colLen <- dim(tempData)[2]
result <- matrix(NA, nrow=subLen*actLen, ncol=colLen) 
result <- as.data.frame(result)
colnames(result) <- colnames(tempData)
row <- 1
for(index in 1:subLen) 
{
    for(inner in 1:actLen) 
	{
        result[row, 1] <- sort(unique(joinSubject)[, 1])[index]
        result[row, 2] <- activity[inner, 2]
        bool1 <- index == tempData$subject
        bool2 <- activity[inner, 2] == tempData$activity
        result[row, 3:colLen] <- colMeans(tempData[bool1&bool2, 3:colLen])
        row <- row + 1
    }
}
write.table(result, "means-data.txt") 

#read and display data
meandata <- read.table("means-data.txt") 
meandata
