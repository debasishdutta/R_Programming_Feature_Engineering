# R_Programming_Feature_Engineering
Feature Engineering For Predictive Model Development

Multicollinearity Check Using Variance Inflation Factor 

Disclaimer: 
This code snippet is developed with an intension for generic use only. I hereby declare that the code was not part of any of my professional development work. Also, no sensitive or confidential data sources are used for this development. 

Description: 
This is a code for multicollinearity check, a must check point before variable selection for any linear model like Regression. The user defined function takes modelling data set without the target variable as input and produces a reduced list of variables which are non-collinear among themselves. The reduced list of variables is selected based on VIF cut off which is taken as second input to the user defined function. The script will be useful in variable selection for a linear model. 

Note: 
1. The script can be used for Regression as well as classification problem. 
2. Modelling data must not have target variable populated and all the variables in modelling data should be either numeric, integer or factor data type. 

Steps For Execution: 
1. Copy the code file to the current working directory of R session. 
2. Import the data in to a R data frame (df_name). Kindly ensure categorical variables are stored as factor data type. 
3. Load the code file using below command: 
source(“Multicollinearity Check.R”) 
4. Execute the code using below command: 
df_vif <- vif_function(df_name,4) #### Second Parameter is VIF Cutoff 

Compatibility: 
The code is developed and tested on RStudio (Version 1.0.44) using R-3.3.2


==========================

Variable Importance Using Information Value &amp; Weight of Evidence 

Disclaimer: 
This code snippet is developed with an intension for generic use only. I hereby declare that the code was not part of any of my professional development work. Also, no sensitive or confidential data sources are used for this development. 

Description: 
This is a code for Variable Importance based on Weight of Evidence and Information Value. The user defined function takes following input parameters: 
1. Training Data Set 
2. Testing Data Set 
3. Dependent Variable name as Character 
4. No of bins to be created on dependent variable (ideally 10) 

The script will produce Information value and Weight of Evidence for each independent variable with respect to the dependent variable. Using IV value user can gauge the relative importance of each independent variable in a typical binary classification problem. Also, WOE can be used for variable transformation like binning (for continuous independent variable) and banding (for categorical independent variable). 

Note: 
1. The script can be used only for binary classification problem. 
2. Training and Testing data must have target variable populated as binary numeric (i.e. either 0 or 1. No other format is permissible) and all other variables should be either numeric, integer or factor data type. Both the data set should have identical variables. 
3. The output of this user defined function will be a list. First element of the list is IV Table and second element of the list is WOE table. User need to extract these tables manually from the list. 

Steps For Execution: 
1. Copy the code file to the current working directory of R session. 
2. Import the data in to a R data frame (df_name). Kindly ensure categorical variables are stored as factor data type. Target variable should be populated as binary numeric i.e. either 0 or 1. No other format is permissible. 
3. Load the code file using below command: 
source(“Variable Importance Using WOE And IV.R”) 
4. Execute the code using below command: 
list_var_imp <- woe_iv_function(df_train,df_test, "y", 10) 
Third Parameter is name of the dependent variable as character string and fourth parameter is the no of bins to be created on dependent variable (ideally 10). 

Compatibility: 
The code is developed and tested on RStudio (Version 1.0.44) using R-3.3.2


=========================

Variable Importance Using Random Forest 

Disclaimer: 
This code snippet is developed with an intension for generic use only. I hereby declare that the code was not part of any of my professional development work. Also, no sensitive or confidential data sources are used for this development. 

Description: 
This is a code for Variable Importance based on Mean Decrease In Accuracy and Mean Decrease In Gini criteria. The user defined function takes following input parameters: 
1. Modelling data set with the target variable 
2. Dependent Variable Name As Character 
3. Weight To Be Given For Mean Decrease In Gini 
The script will produce relative importance rank of each variable with respect to the dependent variable. Also, variable importance plot will be generated and saved in current working directory of R Session. The used defined function can be used for variable selection in a typical modelling exercise. 

Note: 
1. The script can be used for Regression as well as classification problem. Random Forest algorithm is used for relative ranking of variable importance. 
2. Modelling data must have target variable populated and all the variables in modelling data should be either numeric, integer or factor data type. 
3. Weight given to the Mean Decrease In Gini criteria is taken as an input to the user defined function. Weight for Mean Decrease In Accuracy criteria is automatically calculated from weight given to the Mean Decrease In Gini. 

Steps For Execution: 
1. Copy the code file to the current working directory of R session. 
2. Import the data in to a R data frame (df_name). Kindly ensure categorical variables are stored as factor data type. 
3. Load the code file using below command: source(“Variable Importance Using Random Forest.R”) 
4. Execute the code using below command: df_var_imp <- var_importance_function(df_name,"y",0.4) Second Parameter is name of the dependent variable as character string and third parameter is weight given to Mean Decrease In Gini (in the range of 0 to 1). 

Compatibility: 
The code is developed and tested on RStudio (Version 1.0.44) using R-3.3.2


===================


Variable Significance Test Using Wald Statistics 

Disclaimer: 
This code snippet is developed with an intension for generic use only. I hereby declare that the code was not part of any of my professional development work. Also, no sensitive or confidential data sources are used for this development. 

Description: 
This is a code for Variable Significance Test using Wald Statistics. The user defined function takes following input parameters: 
1. Generalized Linear Model or Linear Model R Object 
2. Dependent Variable Name As Character 
3. Significance Level for Wald Test (ideally in the range of 0.01-0.1) 
The script will produce p-value of Wald Test for each independent variable. Also, a separate column will show whether the variable is significant or not based on Significance Level passed to the function. The used defined function can be used for variable selection in a typical modelling exercise. 

Note: 
1. The script can be used for Regression as well as classification problem. 
2. Modelling data must have target variable populated and all the variables in modelling data should be either numeric, integer or factor data type. 
3. Ideally this user defined function can be used for Linear or Logistic Regression. But technically any R object which contains model coefficients can be passed as an input. 

Steps For Execution: 
1. Copy the code file to the current working directory of R session. 
2. Import the data in to a R data frame (df_name). Kindly ensure categorical variables are stored as factor data type. 
3. Load the code file using below command: source(“Variable Significance Test Using Wald Statistics.R”) 
4. Execute the code using below command: df_var_sig <- wald_test_function(model_1,"duration", 0.05). Second Parameter is name of the dependent variable as character string and third parameter is significance level. 

Compatibility: 
The code is developed and tested on RStudio (Version 1.0.44) using R-3.3.2


