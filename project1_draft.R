# just starting on the project here

library(ggplot2)
library(tidyverse)

setwd("/Users/jaans/Desktop/BIOL3140/Scales")

dat <- read.csv("scales.csv")
summary(dat)
dim(dat)
head(dat)

class(dat$N) #numeric
class(dat[,1])
class(dat$quadrant) #character
class(dat$species) #character
class(dat$specimen) #character

#or we can do it in one line:
sapply(dat,class)

#change species column class to a factor:
dat$species <- as.factor(dat$species)
dat$species <- levels(dat$species)
