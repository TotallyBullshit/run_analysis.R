
**CookBook**

 
 Input Data

The script assumes the UCI dataset is extracted into the current working directory

 
 Output Data

The resulting ./UCI HAR Dataset/tidy_data.txt dataset includes mean and standard deviation variables for all the original variables including either mean or std in their original names.

 
 Transformations

The script, run_analysis.R, does the following,

    Load the various files which make-up the UCI dataset
    Merges the three test and three train files into a single data table, setting textual columns heading where possible
    Creates a smaller second dataset, containing only mean and std variables
    Computes the means of this secondary dataset, group by subject/activity.
    Saves this last dataset to ./UCI HAR Dataset/tidy_data.txt


