# Load required libraries
library(httr)
library(jsonlite)
library(dplyr)

source("functions.R")

# Example usage
# species can be
# 1. Yellowhammer (Emberiza citronella);
# 2. Grey partridge (Perdix perdix);
# 3. Lapwing (Vanellus vanellus);
# 4. Corn Bunting (Emberiza calandra);
# 5. Skylark (Alauda arvensis);
# 6. Meadow Pipit (Anthus pratensis);
# 7. Linnet (Linaria cannabina);
# 8. Tree Sparrow (Passer montanus);
# 9. Redstart (Phoenicurus phoenicurus);
# 10. Mistle Thrush (Turdus viscivorus).
bird_calls <- get_filtered_recordings(
  species = "Vanellus vanellus",
  target_duration = 10,
  tolerance = 5.0,
  download = TRUE,
  max_downloads = 10,  # Change this to any number you like
  download_folder = "calls/lapwing"
)

print(bird_calls[, c("gen", "sp", "en", "length", "file")])

