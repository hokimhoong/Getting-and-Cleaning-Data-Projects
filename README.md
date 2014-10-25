# Getting and Cleaning Data Project

##Readme

### Introduction
The script (run_analysis.R) does the following;

1. Merges the training and the test sets to create one data set.

2. Extracts only the measurements on the mean and standard deviation for each measurement. 

3. Uses descriptive activity names to name the activities in the data set

4. Appropriately labels the data set with descriptive activity names. 

5. Creates a second, independent tidy data set with the average of each variable for each activity and each subject. 


### Setup
1. Create a folder name "project" and place run_analysis.R in this folder.  
2. In "project" folder, create a sub folder name "data".
3. Download the data for the project via this [link](https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip) and unzip it into the folder "data"
4. Open the run_analysis.R in R Studio and set the working directory. Refer to the code sample below, this is assume that the "project" folder will be place in the C drive root directory.

```javascript
setwd("C:/project/")
```

### Execution

1. Execute the script in R Studio
2. After successful execution, the script will create 2 file in the root directory, 
   which are means-data.txt and merged-data.txt.
   
   * merged-data.txt contains the appropriately labels the data set with descriptive variable names
   * means-data.txt contains the independent tidy data set with the average of each variable for each activity and each subject