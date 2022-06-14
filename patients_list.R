patients_list <- c(1472, 2582, 
                   4248 , 4923 , 4953,
                   0517 , 2500 , 3473 ,
                   3839 , 4157, 4656,
                   5656, 5854, 6601)
patients_list <- as.character(patients_list)

patients <- paste0("'",
                   paste0(patients_list ,
                              sep = "",collapse = "','"),
                   "'")




