## Load Libraries

library(ggplot2)
library(tidyr)
library(adegenet)
library(ape)
library(poppr)
library(na.tools)
library(paletteer)

# Set working directory

setwd("C:/Users/pred9/OneDrive/Desktop/AU_PhD/Auburn Stuff/Genome Stuff/OrthoVenn/")

# Read in CSVs with Go Enrichment Results and Names for Margaritiferids Only.

input1 <- read.csv("Orthovenn_Margaritiferidae.csv", header = TRUE)

names <- read.csv("Orthovenn_Margaritiferidae_Names.csv", header = TRUE)

# Plot the Results of Go Enrichment for M. margaritifera and M. hembeli

ggplot(input1, aes(fill=GoGroup, y=GeneCount, x=Name)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = names$Name) + coord_flip() + theme_minimal() +
  geom_text(aes(label = GeneCount), hjust = -0.25) # Add labels above the bars

# Read in CSVs with Go Enrichment Results and Names for Margaritifera hembeli Only.

input <- read.csv("Orthovenn_MargHem.csv", header = TRUE)

names <- read.csv("Orthovenn_MargHemNames.csv", header = TRUE)

# Plot the Results of Go Enrichment for M. hembeli

ggplot(input, aes(fill=GoGroup, y=GeneCount, x=Name)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = names$Name) + coord_flip() + theme_minimal() +
  geom_text(aes(label = GeneCount), hjust = -0.25) # Add labels above the bars
