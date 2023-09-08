### MODULE 1 PROJECT | Jaan Selod ###

library(ggplot2) #for plotting
library(tidyverse) #for data analysis

#1. A dat variable containing the scales dataset:
dat <- read.csv("/Users/jaans/Desktop/BIOL3140/Scales/scales.csv")

#2. A line of code which reports the class of each column in the dataset:
sapply(dat,class)

#3. A line of code which reports the dimensions of the dataset
dim(dat)
print(paste("The dimensions of the dataset are ", dim(dat)[1]," by ", dim(dat)[2]))

#4. Code that produces a summary of the number of scales punctured for each species:
species.obs <- dat %>%
  group_by(species) %>%
  summarise(obs_number=n())
species.obs

#5. Code that produces a summary of the number of specimens sampled for each species
dat %>%
  count(species,specimen) %>%
  count(species,name="num_specimens")

#6. Code that produces a PDF file containing 6 figures, one for each species that includes a boxplot
#     of puncture force vs. quadrant:
pdf("Jaan_Selod_Species_Quadrant.pdf")
for(i in species){
  p <- dat %>%
    filter(species==i)%>%
    ggplot() + geom_boxplot(aes(x=quadrant,y=N))+ggtitle(i)
}
dev.off() 
list.files(pattern =".pdf")
