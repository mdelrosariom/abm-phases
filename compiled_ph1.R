library(readxl)
library(openxlsx)
library(stringr) #to exclude patterns, we are going to try

#===============================================================================
#----------------------- CHUNK FOR COMPILE ALL OF THE SIMULATIONS---------------
# make 100 files, each one with the 1000 time steps as rows 

temp_list <- vector("list", 999)  
for (j in 1:999) {
  file_path <- paste0(
    "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/3_output_data_phase_1_1000_run_2_sps/100_per_",
    i, "_", j, ".xlsx"
  )
  temp_list[[j]] <- read_excel(file_path)
}

compiled <- do.call(rbind, temp_list)
write.xlsx(
  compiled,
  paste0("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/100_", i, ".xlsx")
)

#-------------- we should have 100 files per type of simulation (10,50,100)

files <- list.files(path = "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/", pattern = "10", all.files = FALSE,
                    full.names = FALSE, recursive = FALSE,
                    ignore.case = FALSE, include.dirs = FALSE, no.. = FALSE)

for (i in 0:99){
  print(file.exists(paste0("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/comp_sq_100_", i, ".xlsx")))
}

#we have all of the files, but the 100 is comp_sq_100_", i, ".xlsx" and the others 50_, i, ".xlsx or 10_

#===============================================================================
# I did the means, but it does not make so much sense because there are a lot of zeros 

means_10 <- matrix(NA, nrow = 99, ncol = 3)
colnames(means_10) <- c("sim","mean_generalists", "mean_especialists")

for (i in 1:99) {
  file_path <- paste0(
    "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/comp_sq_100_",
    i, ".xlsx"
  )
  
  info <- read_excel(file_path)
  means_10[i,1] <- i
  means_10[i, 2] <- mean(info$number_of_generalists, na.rm = TRUE)
  means_10[i, 3] <- mean(info$number_of_especialist, na.rm = TRUE)
}


write.xlsx(
  as.data.frame(means_10),
  "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/1A_100_MEANS_all_SQ.xlsx"
)


#===============================================================================

means_10 <- read_excel("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/1A_50_MEANS_all_SQ.xlsx")
#means_50 <- read_excel("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/1A_50_MEANS_all.xlsx")

# Extract numeric vectors instead of tibbles
C <- list(
  as.numeric(means_10[[2]]),
  as.numeric(means_10[[3]])
)
C <- lapply(C, function(x) x[x != 0])
# Name the list
names(C) <- c(
  paste("generalist 50"),
  paste("especialist 50")
)

# Adjust mgp to avoid text overlap
par(mgp = c(3, 2, 0))

# Final boxplot
boxplot(C, col = "#69b3a2", ylab = "value")

t.test(means_10[[2]], means_10[[3]])


#===============================================================================
#for when you dont have exactly the number of simulations 

files <- list.files(path = "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/3_output_data_phase_1_1000_run_2_sps/", pattern = "comp_sq_50_", all.files = FALSE,
           full.names = TRUE)


# Preallocate: 99 rows, 2 columns
means_30 <- matrix(NA, nrow = length(files), ncol = 3)
colnames(means_30) <- c("sim","mean_generalists", "mean_especialists")

for (i in 1:length(files)) {
  file_path <- paste0(
    
   files[i]
  )
  
  info <- read_excel(file_path)
  means_30[i,1] <- i
  means_30[i, 2] <- mean(info$number_of_generalists, na.rm = TRUE)
  means_30[i, 3] <- mean(info$number_of_especialist, na.rm = TRUE)
}


write.xlsx(
  as.data.frame(means_30),
  "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/1B_COMP_SQ_30_MEANS_all.xlsx"
)


#===============================================================================

means_30 <- read_excel("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/1A_100_MEANS_all_SQ.xlsx")
#means_50 <- read_excel("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/1A_50_MEANS_all.xlsx")

# Extract numeric vectors instead of tibbles
C <- list(
  as.numeric(means_30[[2]]),
  as.numeric(means_30[[3]])
)
C <- lapply(C, function(x) x[x != 0])
# Name the list
names(C) <- c(
  paste("generalist 100"),
  paste("especialist 100")
)

# Adjust mgp to avoid text overlap
par(mgp = c(3, 2, 0))

# Final boxplot
boxplot(C, col = "#69b3a2", ylab = "value")

t.test(means_30[[2]], means_30[[3]])

#===============================================================================


#===============================================================================
#--------------------------percentage of occupation-----------------------------
# i think i will do this because it makes more sense than using the mean. using the mean is not 
#good because you average runs in which species colonize the island with runs in which this does not 
#happen


occupation_10 <- matrix(NA, nrow = 99, ncol = 2)
colnames(occupation_10) <- c("freq_generalists", "freq_especialists")

for (i in 1:99) {
  file_path <- paste0(
    "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/comp_sq_100_",
    i, ".xlsx"
  )
  
  info <- read_excel(file_path)
  
  generalists_count <- sum(info$number_of_generalists != 0)
  especialists_count <- sum(info$number_of_especialist != 0)
  
 
  occupation_10[i, 1] <- generalists_count / length(info$number_of_generalists)
  occupation_10[i, 2] <- especialists_count / length(info$number_of_especialist)
}

write.xlsx(
  as.data.frame(occupation_10),
  "C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/OCCUPATION_all_sims_100.xlsx"
)

#===============================================================================
#===============================================================================


info <- read_excel("C:/Users/mdrmi/OneDrive/Escritorio/ABM_PHASES_SIMU/compiled_ph_1/OCCUPATION_all_sims_100.xlsx")

C <- list(
  as.numeric(info[[1]]),
  as.numeric(info[[2]])
)
##C <- lapply(C, function(x) x[x != 0])
# Name the list
names(C) <- c(
  paste("generalist 100"),
  paste("especialist 100")
)

# Final boxplot
boxplot(C, col = "#69b3a2", ylab = "value")

t.test(info[[1]], info[[2]])



