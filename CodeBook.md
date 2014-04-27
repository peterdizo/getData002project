Raw data were obtained from the source provided by instructors.

Firstly, these files were imported:

* test/X_test.txt
* train/X_train.txt
* test/y_test.txt
* train/y_train.txt
* test/subject_test.txt
* train/subject_train.txt
* features.txt
* activity_labels.txt
* features.txt

x_test and x_train were merged together using the rbind function forming data frame called data

y_test and y_train were merged together using the rbind function forming data frame called activities

subject_test and subject_train were merged together using the rbind function forming data frame called subjects

activities were transformed from numbers to string labels using the activity_labels file and lapply function

logical vector filt was created using the grepl function to indicate columns which names contain either string "mean()" or "std()"

These columns were then filtered out, according to the project instructions

Columns were named using the filtered features data frame and columns subjects and activities were added using the cbind function to the data data frame

This dataframe was then reordered according to the subjects and activities using the order() function

Data data frame was then melted down using melt function from the reshape2 package where ids were specified to be the subjects and activities.

Consequently, the final tidy dataset was obtained using the dcast function with optional mean function used to aggregate the values for every nonid variable. 

Note: Al additional info regarding the variables, their types and values can be found in the files provided with the raw dataset.


