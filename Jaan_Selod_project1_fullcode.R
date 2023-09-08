### MODULE 1 PROJECT | Jaan Selod Draft ###

library(ggplot2) #for plotting
library(tidyverse) #for data analysis

##loading the data:
dat <- read.csv("/Users/jaans/Desktop/BIOL3140/Scales/scales.csv")
str(dat) #data frame with lists (columns) of different data classes
dim(dat) #gives the dimensions: 1842 rows, 4 columns
head(dat) #gives first 6 lines of the data frame
tail (dat) #gives the last 6 lines

#for my own reference:
# N -> force (Newtons) for needle to puncture a scale
# quadrant -> where is the scale on the body?
  # UL = anterodorsal
  # UR = posterodorsal
  # LL = anteroventral
  # LR = posteroventral
# species -> what species did this scale come from?
# specimen -> which specimen (bc several for each species)

#we can use class() to see how data is stored in R
class(dat$N) #numeric -> continuous
typeof(dat$N) #double/numeric
class(dat$quadrant) #chr
class(dat$species) #chr
class(dat$specimen) #chr

class(dat[,1]) #numeric -> selects column 1?
#and so on for the rest
mean(dat$N) #returns ~4.73
mean(dat$quadrant) #not numeric data!

sapply(dat,class) #make above concise
#argument 1 = data frame
#argument 2 = function

##simple operations: summarizing
#remember that some columns are character classes! Make them to factors, which have levels
# this lets us assign "values" to chrs to analyze, say, how many species
dat$species <- as.factor(dat$species) #overwrites column
species <- levels(dat$species) #reveals the levels in factor-type data
species #we have 6 species
length(species) #6

#what about the amount of observations per species? Logical tests!
species[1] #remember A. rupestris is assigned index 1
dat$species == species[1] 
#the first 363-ish values for species column match "A. rupestris"

dat$species[dat$species == species[1]] #this only returns the values that match species[1]
A.rup <- length(dat$species[dat$species == species[1]])
L.gib <- length(dat$species[dat$species == species[2]])
L.mac <- length(dat$species[dat$species == species[3]])
M.sal <- length(dat$species[dat$species == species[4]])
M.sax <- length(dat$species[dat$species == species[5]])
P.fla <- length(dat$species[dat$species == species[6]])
#and let's combine them!
species.obs <- data.frame(sp=species,n=c(A.rup,L.gib,L.mac,M.sal,M.sax,P.fla))
species.obs #we can see that it's pretty evenly distributed!

#but what if we used tidyverse?
# summarise() creates variables that summarize the data according to variables of interest
# group_by() can be used to set the variables of interest
# pipe convention is %>%, and combines data with these functions
dat %>%
  group_by(species) %>%
  summarise(n=n())
#we're asking R to pass the data (dat) through group_by(), and to group it by the species column
# then, to summarize it according to group with a count, n()
# tibbles are kind of like data frames in terms of data objects
species.n <- dat %>%
  group_by(species) %>%
  summarise(n=n())
species.n

#how about how many specimens per species?
dat %>%
  count(species,specimen) %>%
  print() %>%
  count(species,name="n.specimens")

##loop when you can
for(i in 1:10) {
  print(i)
}

#let's plot the mean puncture force for each quadrant in each species
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot() + geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
#and save all these figures in a pdf
pdf("Jaan_Selod_species_quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot() + geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
  print(p)
}
dev.off() #any plot printed before this and after p() saves the plots in the named file
list.files(pattern=".pdf") #confirms this was saved to our wd
