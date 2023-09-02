library(shiny)

meta <- read.table("data/merged_processed_meta.tsv", sep = "\t", header = TRUE)
db <- read.csv("data/dataset_list.csv")
cancer_type <- data.frame(
    csv = c("BCC", "Breast", "CRC", "ESAD", "Gastric", "Glioblastomas", "HNSCC", 
            "Melanoma", "NSCLC", "RCC", "THYM", "Urothelial", "TNBC"),
    shiny = c("Basel", "Breast", "Colorectal", "Esophagus", "Stomach", "Brain", "Head & Neck", 
              "Melanoma", "Lung", "Kidney", "Thymus", "Bladder", "Breast")
)

meta$Type_Shiny <- cancer_type$shiny[match(meta$Type, 
                                           cancer_type$csv)]

meta$Study_Shiny <- gsub("\\..*\\.", "", 
                         sapply(strsplit(meta$Study, "_"), "[[", 2))

runApp("IOhub/")