################################################################################################
#################  Variable Reduction Using Multicollinearity Check            #################
#########################    Developer:   Debasish Dutta       #################################
#########################    Date:   	    December 2017        ###############################
######                       Input:  1. Data Without Target Var (Only Num & Factor)       ######
######                               2. Numeric Cutoff of VIF (i.e. 4)                    ######
######                       Output: 1. A Data Frame With Reduced List of Variables       ######
################################################################################################

vif_function <- function(df_name, vif_cutoff) {
  ###################### Installing & Loading rms Package ########################
  if (!require("rms", character.only = TRUE))
  {
    install.packages("rms", dep = TRUE)
    if (!require("rms", character.only = TRUE))
      stop("rms Package not found")
  }
  
  
  #################### Converting All Factor Variables In To Numeric Variables #####################
  df_num_converted <-
    data.frame(lapply(df_name, function(y)
      if (is.factor(y))
        as.numeric(y)
      else
        y))
  
  #################### Populating A Random Predictor Variable #####################
  df_num_converted$y <-
    sample(1000,
           size = nrow(df_num_converted),
           replace = TRUE)
  
  #################### Running Initial Linear Model #####################
  lm_model_init <-
    lm(formula = y ~ . - 1,
       data = df_num_converted,
       na.action = na.exclude)
  vif_init <- data.frame(rms::vif(lm_model_init))
  vif_init$Var_Name <- row.names(vif_init)
  names(vif_init) <- c("VIF_Value", "Variable_Names")
  row.names(vif_init) <- NULL
  vif_init <- vif_init[, c(2, 1)]
  
  #################### Removing Variables With Higher VIF #####################
  vif_table <- vif_init
  while (max(vif_table$VIF_Value) >= vif_cutoff) {
    vif_table <-
      vif_table[-which(vif_table$VIF_Value == max(vif_table$VIF_Value)), ]
    df_temp <- df_num_converted[, c(vif_table$Variable_Names, "y")]
    lm_model_temp <-
      lm(formula = y ~ . - 1,
         data = df_temp,
         na.action = na.exclude)
    
    vif_temp <- data.frame(rms::vif(lm_model_temp))
    vif_temp$Var_Name <- row.names(vif_temp)
    names(vif_temp) <- c("VIF_Value", "Variable_Names")
    row.names(vif_temp) <- NULL
    vif_temp <- vif_temp[, c(2, 1)]
    vif_table <- vif_temp
  }
  
  vif_table_final <-
    data.frame(
      Variable_Names = vif_table$Variable_Names,
      VIF_Value = round(vif_table$VIF_Value, digits = 3)
    )
  vif_table_final <-
    vif_table_final[order(vif_table_final$VIF_Value, decreasing = F), ]
  row.names(vif_table_final) <- NULL
  return(vif_table_final)
}
