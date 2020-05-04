################################################################################################
###############################  Variable Importance Plot      #################################
#########################    Developer:   Debasish Dutta       #################################
#########################    Date:   	    December 2017      #################################
######                       Input:       1. Data Frame With Dependent Var                ######
######                                    2. Dependent Variable Name As Character         ######
######                                    3. Weight To Be Given For Mean Decrease In Gini ######
######                       Output:      1. Variable Importance Rank In A Data Frame     ######
######                                    2. Variable Importance Plot                     ######
################################################################################################

var_importance_function <- function(df_name, dep_var, weight_gini) {
  ###################### Installing & Loading randomForest Package ########################
  if (!require("randomForest", character.only = TRUE))
  {
    install.packages("randomForest", dep = TRUE)
    if (!require("randomForest", character.only = TRUE))
      stop("randomForest Package not found")
  }
  
  ###################### Running Random Forest Model ######################
  fml <- as.formula(paste(dep_var, "~.", sep = ""))
  set.seed(12345)
  rf_model <- randomForest(
    fml,
    data = df_name,
    replace = TRUE,
    mtry = floor(sqrt(ncol(df_name) - 1)),
    ntry = 500,
    importance = TRUE
  )
  
  ######################  Variable Ordering ######################
  var_imp_gini <- data.frame(importance(rf_model, type = 2))
  var_imp_gini$Variable_name <- row.names(var_imp_gini)
  row.names(var_imp_gini) <- NULL
  names(var_imp_gini) <- c("Mean_Decrease_Gini", "Variable_Name")
  
  var_imp_accuracy <- data.frame(importance(rf_model, type = 1))
  var_imp_accuracy$Variable_name <- row.names(var_imp_accuracy)
  row.names(var_imp_accuracy) <- NULL
  names(var_imp_accuracy) <-
    c("Mean_Decrease_Accuracy", "Variable_Name")
  
  final_result <-
    merge(var_imp_gini,
          var_imp_accuracy,
          by = "Variable_Name",
          all.x = T)
  final_result$Scaled_Gini <-
    scale(final_result$Mean_Decrease_Gini,
          center = T,
          scale = T)
  final_result$Scaled_Accuracy <-
    scale(final_result$Mean_Decrease_Accuracy,
          center = T,
          scale = T)
  final_result$Importance_Score <-
    (final_result$Scaled_Gini * weight_gini) +
    (final_result$Scaled_Accuracy * (1 - weight_gini))
  final_result <-
    final_result[order(final_result$Importance_Score, decreasing = T), ]
  final_result$Variable_Importance_Rank <- c(1:nrow(final_result))
  final <- data.frame(
    final_result$Variable_Name,
    final_result$Mean_Decrease_Gini,
    final_result$Mean_Decrease_Accuracy,
    final_result$Variable_Importance_Rank
  )
  names(final) <- c(
    "Variable_Name",
    "Mean_Decrease_Gini",
    "Mean_Decrease_Accuracy",
    "Variable_Importance_Rank"
  )
  final <- final[order(final$Variable_Importance_Rank), ]
  
  ############################ Variance Importance Plot ##########################
  jpeg(
    "Variable Importance.jpeg",
    width = 1000,
    height = 500,
    units = "px",
    pointsize = 12,
    quality = 75,
    bg = "white",
    res = NA,
    family = "",
    restoreConsole = TRUE,
    type = c("windows", "cairo")
  )
  varImpPlot(rf_model, sort = T, main = "Variable Importance Plot")
  dev.off()
  
  return(final)
}
