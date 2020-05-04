################################################################################################
#########################  Weight of Evidance & Information Value     ##########################
#########################    Developer:   Debasish Dutta       #################################
#########################    Date:   	    December 2017        ###############################
######                       Input:  1. Train Data (Mixed Data Type Allowed)              ######
######                               2. Test Data  (Mixed Data Type Allowed)              ######
######                               3. Dependent Variable As Numeric(Value i.e. 0/1)     ######
######                               4. No of Bins To Be Created For Numeric Var          ######
######                       Output: 1. A List (First Element: IV Table)                  ######
######                                         (Second Element: WOE Table)                ######
################################################################################################

woe_iv_function <- function(df_train, df_test, dep_var, n_bin) {
  ###################### Installing & Loading Information Package ########################
  if (!require("Information", character.only = TRUE))
  {
    install.packages("Information", dep = TRUE)
    if (!require("Information", character.only = TRUE))
      stop("Information Package not found")
  }
  
  ###################### Generating Information Value Table ########################
  obj_iv <-
    create_infotables(
      data = df_train,
      valid = df_test,
      y = dep_var,
      bins = n_bin
    )
  iv_table <- obj_iv$Summary
  iv_table_final <-
    data.frame(lapply(iv_table, function(y)
      if (is.numeric(y))
        round(y, 3)
      else
        y))
  
  ###################### Generating Weight of Evidence Table ########################
  woe_table <- NULL
  for (i in 1:length(obj_iv$Tables)) {
    temp_table <- obj_iv$Tables[[i]]
    temp_table$Variable_Name <- names(obj_iv$Tables[[i]])[1]
    names(temp_table)[1] <- "Bins"
    temp_table <- temp_table[, c(7, 1:6)]
    woe_table <- rbind(woe_table, temp_table)
  }
  woe_table_final <-
    data.frame(lapply(woe_table, function(y)
      if (is.numeric(y))
        round(y, 3)
      else
        y))
  
  final_result <- list(iv_table_final, woe_table_final)
  return(final_result)
}
