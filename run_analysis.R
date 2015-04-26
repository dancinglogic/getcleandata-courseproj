### 1. Merge the training and the test sets to create one data set.

# The first column in features.txt is the number of the row; 
# we want the name of the feature, which is in column 2
features <- read.table("UCI HAR Dataset/features.txt", 
                       sep=" ",
                       stringsAsFactors=FALSE)$V2

### Get test data and put it together ########################################

# Get the feature vectors so we can 
# "Appropriately label the data set with descriptive variable names." 
X_test <- read.table("UCI HAR Dataset/test/X_test.txt")
names(X_test) <- features

# Get the subject that belongs to each feature vector
# (We can tell because the numbers are between 0 and 30)
subject_test <- read.table("UCI HAR Dataset/test/subject_test.txt")

# Get the label assigned to each feature vector
# (We can tell because the numbers are between 1 and 6)
y_test <- read.table("UCI HAR Dataset/test/y_test.txt")

# Stick the subject, feature vector, and label together
test_data <- cbind(subject_test, X_test, y_test)
names(test_data) <- c("subject", features, "activity")


### Similarly, get training data and put it together #########################
X_train <- read.table("UCI HAR Dataset/train/X_train.txt")
names(X_train) <- features

# Get the subject that belongs to each feature vector
# (We can tell because the numbers are between 0 and 30)
subject_train <- read.table("UCI HAR Dataset/train/subject_train.txt")

# Get the label assigned to each feature vector
# (We can tell because the numbers are between 1 and 6)
y_train <- read.table("UCI HAR Dataset/train/y_train.txt")

# Stick the subject, feature vector, and label together
train_data <- cbind(subject_train, X_train, y_train)
names(train_data) <- c("subject", features, "activity")

### Combine the training and test sets to form one data set ##################
one_data_set <- rbind(test_data, train_data)

# sanity check: are all the subject and label values in the right range?
# Do we have subjects 1 through 30?
print("Have all 30 subjects?")
ans <- all(sort(unique(one_data_set$subject)) == 1:30)
print(ans)
# Do we have activities 1 through 6?
print("Have all 6 activities?")
ans <- all(sort(unique(one_data_set$activity)) == 1:6)
print(ans)
### 2. Extract only the measurements that are a mean or std deviation

# First, what do such features even look like? Find all features containing
# mean or std; be case insensitive.
print("Examining features containing 'mean'")
features[grep("mean", features, ignore.case=TRUE)]
# I don't think we want features where angle() contains "*Mean" as an argument.
# We do want things like "mean()" and "meanFreq()" - that is, all lower case
# occurrences.
features_mean <- features[grep("mean", features)]

print("Examining features containing 'std'")
features[grep("std", features, ignore.case=TRUE)]
# This is easier. Everything with "std" contains "std()" with the parentheses.
features_std <- features[grep("std()", features, ignore.case=TRUE)]

# In our final data set we want the subject, the mean and std deviation 
# features, and the label for which activity we're doing.
features_we_want <- c("subject", features_mean, features_std, "activity")
data_we_want <- one_data_set[,features_we_want]

### 3. Name the activities
# Read in the activity labels. The names are in the second column.
activities <- read.table("UCI HAR Dataset/activity_labels.txt", sep=" ",
                         stringsAsFactors=FALSE)$V2
# Transform the activity column in the data to descriptive labels
# instead of numbers. The original data contains a number for activity;
# use this as an index to find the right descriptive label.
data_we_want$activity <- activities[as.integer(data_we_want$activity)]

### 4. Appropriately label the data set with descriptive variable names
# - We did this already as part of step 1.


### 5. From the data set in step 4, creates a second, independent tidy data 
# set with the average of each variable for each activity and each subject.
library(reshape2)
tidy_data <- melt(data_we_want, id.vars=c("subject", "activity"), 
                  measure.vars=c(features_mean, features_std))
# Compute average of each variable for each subject and activity
wide_format <- dcast(tidy_data, 
                     subject + activity ~ variable, 
                     fun.aggregate=mean)
print("Dimensions of wide_format data:")
print(dim(wide_format))

# Since we have computed the average of each feature we started with, we 
# should probably change the column names to reflect that.
new_mean_features <- sapply(features_mean, 
                            function(x) {paste0( "MEAN(",x,")")})
new_std_features <- sapply(features_std,
                           function(x) {paste0("STD(", x, ")")})
new_features <- c("subject", "activity",new_mean_features, new_std_features)
names(wide_format) <- new_features

# If we wanted to put the data in narrow format:
# narrow_format <- melt(wide_format, id.vars=c("subject", "activity"))

# Write the data set out. Directions say to write it out as .txt.  I am
# using the comma because I like csv files.
write.table(wide_format, "UCI_HAR_Dataset_tidy.txt", sep=",", row.names=FALSE)

# To read in the data set:
# read.table("UCI_HAR_Dataset_tidy.txt", sep=",", header=TRUE)