Codebook for the programming assignment of Course 3 - Getting and Cleaning Data
Below follows a description of how I have constructed this dataset.

Downloaded the dataset from: http://archive.ics.uci.edu/ml/machine-learning-databases/00240/
This data consists of a structured directory structure with two sub-directories: test and train denoting the test-set and the training-set respectively. Information regarding the contents of the directories can be found in the README.txt-file as well as the other files:

First level:

- README.txt - a comprehensive description of the dataset.
- activity_labels.txt - listing the 6 different activities studied in this dataset.
- features_info.txt - a description of the different features.
- features.txt - a list of the 561 different features - which for our purposes may be seen as columns in the starting dataset.
Subdirectories ("test" and "train"):

- subject_test.txt (alt. subject_train.txt): 2947 lines where each lines contains a number ranging from 1-30 (referring to the different subjects that are included in this experiment).
- x_test.txt (alt. y_train.txt): 2947 lines with each line consisting of a value for the 561 different features listed in features.txt above.
- y_test.txt (alt. y:train.txt): 2947 lines each consisting of a value between 1-6, referring to one of the features described in features.txt.
Unzipping data: unzip UCI_HAR_Dataset.zip

A script called run_analysis.R was created.

I prefer to have consistently named files so I changed "X_test.txt" to "x_test.txt" which is consistent with "y_text.txt" as the other file was named.
