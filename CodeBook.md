Code Book for cleansed dataset from the Human Activity Recognition Using Smartphone Dataset Version 1.0
=======

Note on the raw data
-------
A full description of the raw data can be obtained here:
http://archive.ics.uci.edu/ml/datasets/Human+Activity+Recognition+Using+Smartphones 

The raw data for this data set is taken from https://d396qusza40orc.cloudfront.net/getdata%2Fprojectfiles%2FUCI%20HAR%20Dataset.zip 


About tidydata.txt
-------
For each record, it is provided the following:

1. activity - a description of the activity performed by the subject when the measurement was recorded

2. subject - a numerical id of the subject performing the activity

3. variable - description of the measurement type (see notes on measurement type)

4. averageValue - the average value of the measurement type for the given activity and subject

Notes on Measurement Type (feature vector)
-------
1. Refer to the "README.txt" and "features_info.txt" that is part of the raw dataset for a detailed description of how the raw data is collected.

2. The dataset provided here shows the average value of the mean and standard deviation of the measurements provided in the raw data.

..* To obtain the standard deviation, all feature vector with std() in the text are included

..* To obtain the mean, all feature vectors with mean() in the text are included.

3. The feature vector, which is displayed in the variable column, is expanded to a full description on using the following rules:

..* - becomes space

..* mean() becomes mean

..* std() becomes standard deviation

..* first letter t becomes time

..* first letter f becomes frequency

..* Acc becomes accelerometer

..* Gyro becomes gyroscope

..* Mag becomes magnitude

..* Body becomes body

..* Gravity becomes gravity

..* Jerk becomes jerk

4. Where the feature vector description contains a duplicate 'bodybody', the description has been replaced with a single 'body'.


H3 Note about the file:
-------
The data tidydata.txt is written to file using the following R command
`write.table(averageMeasurement, file="tidydata.txt", row.name=FALSE)


License:
-------
Use of this dataset in publications must be acknowledged by referencing the following publication [1] 

[1] Davide Anguita, Alessandro Ghio, Luca Oneto, Xavier Parra and Jorge L. Reyes-Ortiz. Human Activity Recognition on Smartphones using a Multiclass Hardware-Friendly Support Vector Machine. International Workshop of Ambient Assisted Living (IWAAL 2012). Vitoria-Gasteiz, Spain. Dec 2012

This dataset is distributed AS-IS and no responsibility implied or explicit can be addressed to the authors or their institutions for its use or misuse. Any commercial use is prohibited.

Jorge L. Reyes-Ortiz, Alessandro Ghio, Luca Oneto, Davide Anguita. November 2012.
