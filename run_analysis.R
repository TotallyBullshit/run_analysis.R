library(data.table)
library(reshape2)

# define directories from unzipped data file
dir <- "UCI\ HAR\ Dataset"
testdir <- paste(dir, "test", sep="/")
traindir <- paste(dir, "train", sep="/")

# loading all the text files as tables
subject_test <- read.table(paste(testdir, "subject_test.txt", sep="/"))
subject_train <- read.table(paste(traindir, "subject_train.txt", sep="/"))

train_y <- read.table(paste(traindir, "y_train.txt", sep="/"))
test_y <- read.table(paste(testdir, "y_test.txt", sep="/"))

train_x <- read.table(paste(traindir, "X_train.txt", sep="/"))
test_x <- read.table(paste(testdir, "X_test.txt", sep="/"))

# only load the names column from the following 2 files
feature_names <- read.table(paste(dir, "features.txt", sep="/"))[,2]
activity_names <- read.table(paste(dir, "activity_labels.txt", sep="/"))[,2]

# bind and label the subject names from the test and train files
subject <- rbind(subject_test, subject_train)
colnames(subject) <- "SubjectNumber"

# Label the test and train data sets
names(test_x) = feature_names
names(train_x) = feature_names
# Subset the mean  and standard deviation entries from the data sets
test_x = test_x[,grepl("mean|std", feature_names)]
train_x = train_x[,grepl("mean|std", feature_names)]
# bind the test and train data sets
data = rbind(test_x, train_x)

# add a column with the activities description and bind the 2 sets
test_y[,2] = activity_names[test_y[,1]]
train_y[,2] = activity_names[train_y[,1]]
activities = rbind(test_y, train_y)
# label the columns
names(activities) = c("ActivityID", "ActivityLabel")

# combine all 3 tables
data <- cbind(as.data.table(subject), activities, data)

# Calculate average of each variable for each activity and each subject
id_labels   = c("SubjectNumber", "ActivityID", "ActivityLabel")
data_labels = setdiff(colnames(data), id_labels)
prep_data = melt(data, id = id_labels, measure.vars = data_labels)
final_data = dcast(prep_data, SubjectNumber + ActivityLabel ~ variable, mean)

# write the tidy dataset to a file
write.table(final_data, file = paste(dir, "tidy_data.txt", sep="/"))