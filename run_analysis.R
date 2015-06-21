setwd("D://Data science specialisation//Data specialisation repo//Cleaning data//course project")
install.packages("dplyr")
library(dplyr)

activityLabels <- read.table("activity_labels.txt")
variablesNames <- read.table("features.txt")

#********************Prepare training set******************************

subjectTrain <- read.table("subject_train.txt")
trainingSet <- read.table("X_train.txt")
trainingActivities <- read.table("y_train.txt")

#name variables appropriately
names(trainingSet) <- variablesNames$V2
names(subjectTrain) <- "Subjects"
names(activityLabels) <- c("ActivityNumber","ActivityName")

#create vector with appropriately named activities
mappedActivity <- activityLabels[trainingActivities[,1],2]

#finalise training set
trainingSet <-cbind(subjectTrain$Subjects, trainingSet)
trainingSet <-cbind(mappedActivity, trainingSet)
names(trainingSet)[1] <- "Activity"
names(trainingSet)[2] <- "Subjects" 
setIndicator <- rep("Training",nrow(trainingSet))
trainingSet <-cbind(setIndicator, trainingSet)

rm(subjectTrain,trainingActivities,mappedActivity,setIndicator)

#********************Prepare test set******************************
subjectTrain <- read.table("subject_test.txt")
testSet <- read.table("X_test.txt")
trainingActivities <- read.table("y_test.txt")

#name variables appropriately
names(testSet) <- variablesNames$V2
names(subjectTrain) <- "Subjects"
names(activityLabels) <- c("ActivityNumber","ActivityName")

#create vector with appropriately named activities
mappedActivity <- activityLabels[trainingActivities[,1],2]

#finalise training set
testSet <-cbind(subjectTrain$Subjects, testSet)
testSet <-cbind(mappedActivity, testSet)
names(testSet)[1] <- "Activity"
names(testSet)[2] <- "Subjects" 
setIndicator <- rep("Testing",nrow(testSet))
testSet <-cbind(setIndicator, testSet)

rm(subjectTrain,trainingActivities,mappedActivity,setIndicator)
#********************Merge testing and training******************************

ttSet <- rbind(trainingSet,testSet)


#Extracts only the measurements on the mean and standard deviation for each measurement
columnsToRetain <- c(grep("std()",names(ttSet),ignore.case = TRUE),grep("mean()",names(ttSet),ignore.case = TRUE))
      

ttSetUpdated <- ttSet[,c(1,2,3,columnsToRetain)]


#********Create tidy data set*************
tidySet <- summarise_each(group_by(ttSetUpdated, Activity, Subjects), funs(mean), 4:ncol(ttSetUpdated))

#name the columns appropriately
names(tidySet)[3:ncol(tidySet)] <- paste("Mean.of.",names(tidySet)[3:ncol(tidySet)])
write.table(tidySet,"tidySet.txt",row.name=FALSE)
