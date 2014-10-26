Project Coursework for Getting and Cleaning Data
=======
Introduction
-------
This script takes the raw data provided by the Human Activity Recognition Using Smartphones Dataset and produces a cleansed dataset. 

See CodeBook.md for a description of the data produced.

Source of data:
-------

https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 

Libraries used in this script
-------
library(dplyr)

library(tidyr)

library(reshape2)


Script Breakdown
-------

The script for producing the tidy data is broken into 10 sections:

1. Read the raw data into memory.

2. Each dataframe is given meaningful column names.

3. For both the test and train dataset, merge the subject, activity and measurment data; then merge the test and training data.

4. Clean up any dataset that is no longer used (to release memory).

5. Extract the mean and standard deviation of each measurement type.

6. Change the activity name to show the descriptive name.

7. Reshape the data to be a long data set, then calculate the average for each activity/subject/measurement type.

8. Tidied the data in the measurement.

9. Write the tidied data into a file "tidydata.txt".

10. Remove all data and temporary variables used.

Instructions for running this script
-------
1. Download and unzip the source data file into the working directory.
2. Install the required libraries.
3. Run run_analysis.R.
4. The cleansed data file ("tidydata.txt") will be found in the working directory.


