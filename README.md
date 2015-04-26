# Course Project for "Getting and Cleaning Data"

This is the course project for the "Getting and Cleaning Data" class offered by JHU through Coursera.

## Data Set Information:

The initial data for this project consisted of data from the embedded accelerometer and gyroscope of a Samsung Galaxy S II smartphone. The smartphones were 
worn by 30 volunteers (subjects) performing 6 different activities (WALKING, WALKING_UPSTAIRS, WALKING_DOWNSTAIRS, SITTING, STANDING, LAYING). The data set had 
been broken up into testing and training data, with three files in each set relevant to this project:
* subject identifiers, as integers from 1:30
* feature vectors
* activity labels, as integers from 1:6

More information on the full experiment may be found [here](http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones).

## run_analysis.R

This R script takes the initial data and creates a new tidy data set as follows:
* Within each of the train and test folders, the three files with subject, activity, and feature information were combined so that we had subject id, features, and activity label on a single line.
The columns were labeled with the names of the features.
* The two data sets resulting from the previous step were combined to provide a single data set.
* Only those features containing 'mean' or 'std' were retained.
* The activity labels were transformed from integers to descriptive strings.
* For each subject and activity, the mean of each retained figure was computed.

## Codebook

subject - A number from 1-30 identifying the volunteer to whom the readings on this line belong

activity label - The activity being performed by the volunteer. One of "WALKING", "WALKING_UPSTAIRS", "WALKING_DOWNSTAIRS", "SITTING", "STANDING", "LAYING".

### As described in the original work:

"The features selected for this database come from the accelerometer and gyroscope 3-axial raw signals tAcc-XYZ and tGyro-XYZ. 
These time domain signals (prefix 't' to denote time) were captured at a constant rate of 50 Hz. Then they were filtered using a median filter and a 3rd order low pass Butterworth filter with a corner frequency of 20 Hz to remove noise. Similarly , the acceleration signal was then separated into body and gravity acceleration signals (tBodyAcc-XYZ and tGravityAcc-XYZ) using another low pass Butterworth filter with a corner frequency of 0.3 Hz.

Subsequently, the body linear acceleration and angular velocity were derived in time to obtain Jerk signals (tBodyAccJerk-XYZ and tBodyGyroJerk-XYZ). Also the magnitude of these three-dimensional signals were calculated using the Euclidean norm (tBodyAccMag, tGravityAccMag, tBodyAccJerkMag, tBodyGyroMag, tBodyGyroJerkMag).

Finally a Fast Fourier Transform (FFT) was applied to some of these signals producing fBodyAcc-XYZ, fBodyAccJerk-XYZ, fBodyGyro-XYZ, fBodyAccJerkMag, fBodyGyroMag, fBodyGyroJerkMag. (Not
e the 'f' to indicate frequency domain signals).

These signals were used to estimate variables of the feature vector for each pattern:
'-XYZ' is used to denote 3-axial signals in the X, Y and Z directions."

### Our features:

For each feature in the original work that was a mean or a standard deviation, we have take the mean of that feature
across all readings for each (subject, activity) pair.  We have denoted this by renaming our features as MEAN(original_feature). The features
we kept from the original work are listed below.

#### The following features are recorded for all three axes, so for * in (X,Y,Z):

tBodyAcc-mean()-*

tGravityAcc-mean()-*

tBodyAccJerk-mean()-*

tBodyGyro-mean()-*

tBodyGyroJerk-mean()-*

fBodyAcc-mean()-*

fBodyAcc-meanFreq()-*

fBodyAccJerk-mean()-*

fBodyAccJerk-meanFreq()-*

fBodyGyro-mean()-*

fBodyGyro-meanFreq()-*

tBodyAcc-std()-*

tGravityAcc-std()-*

tBodyAccJerk-std()-*

tBodyGyro-std()-*

tBodyGyroJerk-std()-*

fBodyAcc-std()-*

fBodyAccJerk-std()-*

fBodyGyro-std()-*


#### The following features are already aggregate:

tBodyAccMag-mean()

tGravityAccMag-mean()

tBodyAccJerkMag-mean()

tBodyGyroMag-mean()

tBodyGyroJerkMag-mean()

fBodyAccMag-mean()

fBodyAccMag-meanFreq()

fBodyBodyAccJerkMag-mean()

fBodyBodyAccJerkMag-meanFreq()

fBodyBodyGyroMag-mean()

fBodyBodyGyroMag-meanFreq()

fBodyBodyGyroJerkMag-mean()

fBodyBodyGyroJerkMag-meanFreq()

tBodyAccMag-std()

tGravityAccMag-std()

tBodyAccJerkMag-std()

tBodyGyroMag-std()

tBodyGyroJerkMag-std()

fBodyAccMag-std()

fBodyBodyAccJerkMag-std()

fBodyBodyGyroMag-std()

fBodyBodyGyroJerkMag-std()

