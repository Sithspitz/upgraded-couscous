# Install Packages
library("utils")
library("ggbiplot")
library("tidyverse")
library("tibble")

# Set Working Directory (change each experiment)
setwd("PCA November 2018 TCM All/")

# Check Working Directory
getwd()

# Import Luminex Data (change each experiment)
luminextotal <- read.csv("RJB_21_Plex_Replicates _Collated_For_PCA_191118_MT.csv", stringsAsFactors = FALSE)

# Check Import Structure
str(luminextotal)

# Assign First Column as Row Names
rownames(luminextotal) <- luminextotal$Sample
luminextotal %>% remove_rownames() %>% column_to_rownames(var ="Sample")

# PCA Group Assigning
## Make sure that there are no blank recurrant columns of values
## Don't include the first column with samples names as character string
luminextotal.pca <- prcomp(luminextotal[,c(3:14)], center = T, scale. = T)
summary(luminextotal.pca)

# Assigning Samples To MT Groups
## The number after the group represents the number of rows with this MT
mt_groups <- c(rep("WT", 6), rep("KRAS", 2), rep("STK11", 4), rep("KRAS/STK11", 4))

# Make A Plot
ggbiplot(luminextotal.pca, ellipse = F, obs.scale = 1, var.scale = 1, choices = c(1,2), 
         var.axes = T, varname.size = 1.25, labels = rownames(luminextotal), groups = mt_groups, labels.size = 1.75) + ggtitle("Luminex TCM PCA")
         
# Export The Plot
ggsave('Luminex TCM PCA.pdf', last_plot())

