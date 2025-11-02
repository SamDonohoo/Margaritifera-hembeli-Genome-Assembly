# Load Libraries

library(ggplot2)
library(tidyr)
library(adegenet)
library(ape)
library(poppr)
library(na.tools)
library(paletteer)

# Set working directory

setwd("C:/Users/pred9/OneDrive/Desktop/AU_PhD/Auburn Stuff/Genome Stuff/A Figures/")

# Read in CSVs with KEGG Results and Names

input <- read.csv("Kegg_for_Graphing.csv", header = TRUE)

names <- read.csv("Kegg_for_Graphing_Names.csv", header = FALSE)

# Plot the Overall Comparisons between KEGG Pathways

ggplot(input, aes(fill=Function, y=Kegg, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = names$V1) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Kegg), hjust = -0.25) # Add labels above the bars

# Read in CSVs with KEGG Pathway Breakdowns and Names

input2 <- read.csv("Kegg_Function_Breakdown.csv", header = TRUE)

names2 <- read.csv("Kegg_Function_Breakdown_Names.csv", header = TRUE)

# Use the Name Order from Names2 within Plots by Factoring

input$Pathways <- factor(input$Pathways, levels = names2$Pathways)

# Subset Pathways Relating to Cellular Processes

Cell <- input2[grepl("Cellular Processes", input2$Function),]

ggplot(Cell, aes(fill=Split, y=Genes, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = Cell$Pathways) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Genes), hjust = -0.25) # Add labels above the bars

# Subset Pathways Relating to Environmental Information Processing

Envir <- input2[grepl("Environmental Information Processing", input2$Function),]

ggplot(Envir, aes(fill=Split, y=Genes, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = Envir$Pathways) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Genes), hjust = -0.25) # Add labels above the bars

# Subset Pathways Relating to Genetic Information Processing

Genetic <- input2[grepl("Genetic Information Processing", input2$Function),]

ggplot(Genetic, aes(fill=Split, y=Genes, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = Genetic$Pathways) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Genes), hjust = -0.25) # Add labels above the bars

# Subset Pathways Relating to Human Diseases

Human <- input2[grepl("Human Diseases", input2$Function),]

ggplot(Human, aes(fill=Split, y=Genes, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = Human$Pathways) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Genes), hjust = -0.25) # Add labels above the bars

# Subset Pathways Relating to Metabolism

Meta <- input2[grepl("Metabolism", input2$Function),]

ggplot(Meta, aes(fill=Split, y=Genes, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = Meta$Pathways) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Genes), hjust = -0.25) # Add labels above the bars

# Subset Pathways Relating to Organismal Systems

Organ <- input2[grepl("Organismal Systems", input2$Function),]

ggplot(Organ, aes(fill=Split, y=Genes, x=Pathways)) + 
  geom_bar(position="dodge", stat="identity") +
  scale_x_discrete(limits = Organ$Pathways) + coord_flip() + theme_minimal() +
  geom_text(aes(label = Genes), hjust = -0.25) # Add labels above the bars
