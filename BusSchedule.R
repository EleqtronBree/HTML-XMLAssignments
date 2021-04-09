#Question 1 - Reading the CSV file
bus1 <- read.csv("2017-03-09-22-04.csv")
head(bus1)
dim(bus1)

#Question 2 - Getting max and min delay
delay <- bus1[,1]
behindMax <- max(delay) / 60
aheadMax <- min(delay) / 60
aheadMax
behindMax

#Question 3 - Generating a set of file names
filenames <- list.files(path=".", pattern = ".csv")
head(filenames)
length(filenames)

#Question 4 - Getting largest ahead and behind schedule across all files
bmax <- 0
amax <- 0
for (i in filenames) {
  delay <- read.csv(i)[,1]
  #If ahead-schedule for this file is larger
  if (min(delay) < amax) {
    amax <- min(delay)
  }
  #If behind-schedule for this file is larger
  if (max(delay) > bmax) {
    bmax <- max(delay)
  }
}
amax <- amax / 60 #convert seconds into minutes
bmax <- bmax / 60
amax
bmax

#Question 5 - Calculates which delays are a multiple of 60 seconds
bus1 <- read.csv("2017-03-09-22-04.csv")
delay <- bus1[,1]
multipleDelay <- delay %% 60 == 0
multipleDelay

#Question 6 - Getting largest ahead and behind schedule in bus1 (EXCLUDING values that are a multiple of 60)
ahead_delay <- min(delay[!multipleDelay], na.rm = TRUE)
behind_delay <- max(delay[!multipleDelay], na.rm = TRUE)
aheadMaxNotMult <- ahead_delay / 60
behindMaxNotMult <- behind_delay / 60
aheadMaxNotMult
behindMaxNotMult

#Question 7 - Same thing as Q6, but this time we are getting values across all files
filenames <- list.files(path=".", pattern = ".csv")
amaxNotMult <- 0
bmaxNotMult <- 0
for (i in filenames) {
  delay <- read.csv(i)[,1]
  multipleDelay <- delay %% 60 == 0
  delay_not_mult <- delay[!multipleDelay]
  ahead_delay <- min(delay_not_mult, na.rm = TRUE)
  behind_delay <- max(delay_not_mult, na.rm = TRUE)
  if (ahead_delay < amaxNotMult){
    amaxNotMult <- ahead_delay
  }
  if (behind_delay > bmaxNotMult){
    bmaxNotMult <- behind_delay
  }
}
amaxNotMult <- amaxNotMult / 60
bmaxNotMult <- bmaxNotMult / 60
amaxNotMult
bmaxNotMult

#Question 8 - calculated largest ahead and behind schedule time for only first stops across all files
filenames <- list.files(path=".", pattern = ".csv")
amaxStop1 <- 0
bmaxStop1 <- 0
for (i in filenames) {
  delay <- read.csv(i)[,c(1,3)]
  #delays from first stop only
  is_stop1 <- delay[,2] == 1
  delay_stop1 <- delay[,1][is_stop1]
  delay[,1][is_stop1]
  #excluding delay of multiple of 60
  multipleDelay <- delay_stop1 %% 60 == 0
  delay_not_mult <- delay_stop1[!multipleDelay]
  #if there are delays not of multiple of 60
  if (length(delay_stop1[!multipleDelay]) > 0){
    ahead_delay <- min(delay_not_mult, na.rm = TRUE)
    behind_delay <- max(delay_not_mult, na.rm = TRUE)
    if (ahead_delay < amaxStop1){
      amaxStop1 <- ahead_delay
    }
    if (behind_delay > bmaxStop1){
      bmaxStop1 <- behind_delay
    }
  }
}
amaxStop1 <- amaxStop1 / 60
bmaxStop1 <- bmaxStop1 / 60
amaxStop1
bmaxStop1
