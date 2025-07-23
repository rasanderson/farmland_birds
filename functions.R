# Functions to make processing easier

# Helper function to convert "mm:ss" to seconds
convert_to_seconds <- function(time_str) {
  parts <- strsplit(time_str, ":")[[1]]
  if (length(parts) == 2) {
    return(as.numeric(parts[1]) * 60 + as.numeric(parts[2]))
  } else {
    return(NA)
  }
}

# Function to get and filter Xeno-canto recordings
get_filtered_recordings <- function(species, target_duration = 6, tolerance = 0.5,
                                    download = FALSE, max_downloads = Inf, download_folder = "xeno_canto_downloads") {
  download_name <- download_folder
  base_url <- "https://xeno-canto.org/api/2/recordings"
  query <- gsub(" ", "+", species)
  page <- 1
  all_recordings <- list()
  
  repeat {
    url <- paste0(base_url, "?query=", query, "&page=", page)
    response <- GET(url)
    data <- fromJSON(content(response, "text", encoding = "UTF-8"))
    
    if (length(data$recordings) == 0) break
    
    recordings <- data$recordings %>%
      mutate(duration_sec = sapply(length, convert_to_seconds)) %>%
      filter(!is.na(duration_sec)) %>%
      filter(abs(duration_sec - target_duration) <= tolerance)
    
    all_recordings <- bind_rows(all_recordings, recordings)
    
    if (page >= as.numeric(data$numPages)) break
    page <- page + 1
  }
  
  if (download && nrow(all_recordings) > 0) {
    dir.create(file.path("calls", download_folder), showWarnings = FALSE)
    n_to_download <- min(nrow(all_recordings), max_downloads)
    
    pb <- txtProgressBar(min = 0, max = n_to_download, style = 3)
    
    # Create the folder if it doesn't exist
    if (!dir.exists(file.path("calls", download_name))) {
      dir.create(file.path("calls", download_name), recursive = TRUE)
    }
    
    for (i in 1:n_to_download) {
      file_url <- all_recordings$file[i]
      dest_file <- file.path("calls", download_name, sprintf("%s_%03d.mp3", download_name, i))
      try(download.file(file_url, destfile = dest_file, mode = "wb"), silent = TRUE)
      setTxtProgressBar(pb, i)
    }
    close(pb)
  }
  
  return(all_recordings)
}
