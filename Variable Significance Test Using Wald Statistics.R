################################################################################################
####################  Variable Significane Check Using Wald Test            ####################
#########################    Developer:   Debasish Dutta       #################################
#########################    Date:   	    December 2017      #################################
######                       Input:  1. GLM Or LM Regression R Object                     ######
######                               2. Dependent Variable Name As Character              ######
######                               3. Significance Level For Wald Test                  ######
######                       Output: 1. A Data Frame With Variable Significane Status     ######
################################################################################################

wald_test_function <- function(model_obj, dep_var, sig_level) {
  ###################### Installing & Loading survey Package ########################
  if (!require("survey", character.only = TRUE))
  {
    install.packages("survey", dep = TRUE)
    if (!require("survey", character.only = TRUE))
      stop("survey Package not found")
  }
  
  ###################### Extracting List of Variables Used in Model ########################
  var_list <-
    names(data.frame(model_obj$model))[-which(names(data.frame(model_obj$model)) %in% dep_var)]
  
  ###################### Extracting Wald Statistics For All Variables ########################
  final_table <- NULL
  for (i in 1:length(var_list)) {
    p_val_temp <- regTermTest(model_obj, var_list[i])$p[1, 1]
    temp_table <- data.frame(Var_Name = var_list[i],
                             P_Value = p_val_temp)
    final_table <- rbind(final_table, temp_table)
  }
  
  final_table$P_Value <- round(final_table$P_Value, digits = 3)
  final_table$Status <-
    ifelse(final_table$P_Value < sig_level,
           "Significant",
           "Insignificant")
  
  return(final_table)
}
