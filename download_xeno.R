# Load required libraries
library(httr)
library(jsonlite)
library(dplyr)

source("functions.R")

# Example usage
# species can be
# common_name <- "Yellowhammer"; latin_name <- "Emberiza citrinella"
# common_name <- "Grey partridge"; latin_name <- "Perdix perdix"
# common_name <- "Lapwing"; latin_name <- "Vanellus vanellus"
# common_name <- "Corn Bunting"; latin_name <- "Emberiza calandra"
# common_name <- "Skylark"; latin_name <- "Alauda arvensis"
# common_name <- "Meadow Pipit"; latin_name <- "Anthus pratensis"
# common_name <- "Linnet"; latin_name <- "Linaria cannabina"
# common_name <- "Tree Sparrow"; latin_name <- "Passer montanus"
# common_name <- "Redstart"; latin_name <- "Phoenicurus phoenicurus"
# common_name <- "Mistle Thrush"; latin_name <- "Turdus viscivorus"
common_name <- "Yellowhammer"; latin_name <- "Emberiza citrinella"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Grey partridge"; latin_name <- "Perdix perdix"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Lapwing"; latin_name <- "Vanellus vanellus"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Corn Bunting"; latin_name <- "Emberiza calandra"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Skylark"; latin_name <- "Alauda arvensis"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Meadow Pipit"; latin_name <- "Anthus pratensis"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Linnet"; latin_name <- "Linaria cannabina"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Tree Sparrow"; latin_name <- "Passer montanus"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Redstart"; latin_name <- "Phoenicurus phoenicurus"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)

common_name <- "Mistle Thrush"; latin_name <- "Turdus viscivorus"
bird_calls <- get_filtered_recordings(
  species = latin_name,
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = common_name
)


# print out a set of calls if needed
#print(bird_calls[, c("gen", "sp", "en", "length", "file")])

