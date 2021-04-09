#Q1 create a sequence of numbers from 11 to 18 and generate a list of filenames
numbers <- 11:18
filenames <- paste("immunisation-ethnicity-20", numbers,"-6-months.csv", sep="")
print(filenames)

#Q2 Read each file and get max value from each
for (i in filenames){
  value <- read.csv(i, row.names=1)
  message <- paste("The maximum value in the file", i, "is", max(value, na.rm = TRUE), "\n")
  cat(message)
}

#Q3 Calculated proportion of children immunised across files
total.immunised <- NULL
total.eligible <- NULL
for (i in filenames){
  value <- read.csv(i, row.names=1)
  #getting sum of values in each column
  NZE.immunised <- sum(value$NZE.Immunised, na.rm = TRUE)
  NZE.eligible <- sum(value$NZE.Eligible, na.rm = TRUE)
  maori.immunised <- sum(value$Maori.Immunised, na.rm = TRUE)
  maori.eligible <- sum(value$Maori.Eligible, na.rm = TRUE)
  pacific.immunised <- sum(value$Pacific.Immunised, na.rm = TRUE)
  pacific.eligible <- sum(value$Pacific.Eligible, na.rm = TRUE)
  asian.immunised <- sum(value$Asian.Immunised, na.rm = TRUE)
  asian.eligible <- sum(value$Asian.Eligible, na.rm = TRUE)
  other.immunised <- sum(value$Other.Immunised, na.rm = TRUE)
  other.eligible <- sum(value$Other.Eligible, na.rm = TRUE)
  #adding the sum of immunised or eligible values into a collection of values
  total.immunised <- c(total.immunised, sum(NZE.immunised, maori.immunised, pacific.immunised, asian.immunised, other.immunised))
  total.eligible <- c(total.eligible, sum(NZE.eligible, maori.eligible, pacific.eligible, asian.eligible, other.eligible))
}

immProp <- sum(total.immunised) / sum(total.eligible)
print(immProp)
