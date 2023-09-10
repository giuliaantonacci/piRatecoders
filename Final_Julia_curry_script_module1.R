library(ggplot2)
library(tidyverse)

#A dat variable containing the scales dataset.
dat <- read.csv("scales.csv")

#A line of code which reports the class of each column in the dataset.
class_column_dat <- sapply(dat,class)
print (class_column_dat)

#A line of code which reports the dimensions of the dataset.
dim(dat)

#Code that produces a summary of the number of scales punctured for each species.
species.obs <- dat %>%
  group_by(species) %>%
  summarise(obs_number=n())
species.obs

#Code that produces a summary of the number of specimens sampled for each species.
dat %>% 
  count(species,specimen) %>%
  print() %>%
  count(species,name = "n.specimens")

#Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot of puncture force verus quadrant.

pdf("Julia_Curry_Species_Quadrant2.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot() + geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
}
dev.off() 
