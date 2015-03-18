# Code Book for Getting And Cleaning Data Assignment

### Variable explanation

There are two sets of data: training data and testing data. We are writing a simple R application and not a cool machine learning algorithm, so like barbarians we just merge the data together. What a shame. In each set there is the *X* set, which presents the measured values in columns, while each row separates the measurement. We get the column labels from the *features* file. The *Y* set represents the activity name and *subjects* show us, which of the 30 subjects was responsible for the measurement. *activity_labels* bind the numeric values to the actual names of activities.