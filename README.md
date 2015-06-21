# Cleaning_Data_course_projec

The run_analysis.R script:

1. Inputs

It takes 8 input files:

3 files related to smartwatch data used for testing:
  subject_train.txt - Each row identifies the subject who performed the activity for each window sample. Its range is from 1 to 30.
  X_train.txt - Training set containing a 561-feature vector with time and frequency domain variables from the accelerometer and gyroscope sensors.
  y_train.txt - Training labels indicating the type of acticity measured i.e. (1) WALKING, (2) WALKING_UPSTAIRS, (3) WALKING_DOWNSTAIRS, (4) SITTING, (5) STANDING, (6) LAYING

3 files related to the training data - the same structure as above

2 mapping files:
activity_labels.txt - maps acitivity number to activity name
features.txt - identifies the name of each variables in the X_train.txt or X_test.txt files


  2. Transformation
  
  The script joins the testing and training sets together by appending the testing set below the training one.
  It identifies the subject and activity for each observation (row)
  Then it creates a new set (tidySet) that summarises mean and standard deviation of signal data for each observation by calculation the mean of each.
  
  3. Output
  
  It outputs tidySet.txt with the tidy set explain above.
  
