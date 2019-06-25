#data types
x<-"Hello world!"
print(x)
i<-123L
l<-TRUE
n<-1.23
d<-as.Date("2002-08-12")

#creating a function
f<-function(x){x+1}
f(2)

#creating a vector
v <- c(1,2,3);
v

#creating a sequence
s<- 1:5
s

#creating a matrix
m<- matrix(
  data=1:6,
  nrow=2,
  ncol=3
  )
m
#creating an 3D array
a<- array(
  data=1:8,
  dim=c(2,2,2)
)

a
#create a list
myList<-list(TRUE,123L,2.34,"abc")
myList

#creating a factor
categories <- c("Male","Female","Male","Male","Female")
factor<- factor(categories)
factor
levels(factor)
unclass(factor)

#creating a data frame
df<-data.frame(
  Name=c("Cat","Dog","Cow","Pig"),
  HowMany=c(5,10,15,20),
  IsPet=c(TRUE,TRUE,FALSE,FALSE))
df
df[1,2]
df[1,]
#Indexing data frames by column
df[,2]
df[["HowMany"]]
df$HowMany

#subsetting data frames
df[c(2,4),]
df[2:4,]
df[c(TRUE,FALSE,TRUE,FALSE),]#indicating which rows we want or not
df[df$IsPet==TRUE,]
df[df$HowMany>10,]
df[df$Name%in% c("Cat", "Cow"),]

#R is vectorized langurage
1+2
c(1,2,3) + c(2,4,6)

# Names vs. ordered arguments
m<- matrix(data=1:6,nrow=2,ncol=3)
n<-matrix(1:6,2,3)
m==n
identical(m,n)

#installing packages
install.packages("dplyr")
#loading packages
library("dplyr")

install.packages("tidyverse")
library(tidyverse) # need to shutdown McAfee LOL

#viewing help
?data.frame
