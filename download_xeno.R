# Load required libraries
library(httr)
library(jsonlite)
library(dplyr)

source("functions.R")

# Example usage
yellowhammer_calls <- get_filtered_recordings(
  species = "Emberiza citrinella",
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = "calls/yellowhammer"
)

print(yellowhammer_calls[, c("gen", "sp", "en", "length", "file")])

