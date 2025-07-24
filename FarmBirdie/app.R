library(shiny)
library(bslib)
library(birdnetR)
library(DT)

ui <- page_sidebar(
  title = "Bird Species Identification from Audio",
  sidebar = sidebar(
    # File upload for WAV file
    fileInput("wav_file", 
              "Upload WAV File",
              accept = c(".wav", ".WAV")),
    
    # Confidence threshold
    numericInput("confidence_threshold",
                 "Confidence Threshold",
                 value = 0.1,
                 min = 0,
                 max = 1,
                 step = 0.05),
    
    # Analysis button
    actionButton("analyze", "Analyze Audio", 
                 class = "btn-primary",
                 style = "width: 100%;")
  ),
  
  # Main panel with results
  card(
    card_header("Analysis Results"),
    conditionalPanel(
      condition = "input.analyze > 0",
      card(
        card_header("Detection Summary"),
        verbatimTextOutput("summary")
      ),
      card(
        card_header("Species Detections"),
        DT::dataTableOutput("detections_table")
      ),
      card(
        card_header("Audio File Information"),
        verbatimTextOutput("audio_info")
      )
    )
  )
)

server <- function(input, output, session) {
  # Reactive values to store results
  values <- reactiveValues(
    detections = NULL,
    audio_path = NULL
  )
  
  # Process uploaded file
  observeEvent(input$wav_file, {
    if (!is.null(input$wav_file)) {
      values$audio_path <- input$wav_file$datapath
    }
  })
  
  # Perform bird species identification
  observeEvent(input$analyze, {
    req(input$wav_file)
    
    tryCatch({
      # Load the custom model using the correct birdnetR workflow
      model <- birdnet_model_custom("v2.4", "custom", "farmbird")
      
      # Predict species from audio using the loaded model
      detections <- predict_species_from_audio_file(model, values$audio_path)
      
      # Filter by confidence threshold
      if (!is.null(detections) && nrow(detections) > 0) {
        detections <- detections[detections$confidence >= input$confidence_threshold, ]
      }
      
      values$detections <- detections
      
      # Show appropriate notification
      if (is.null(detections) || nrow(detections) == 0) {
        showNotification("No species detected above the confidence threshold.", 
                         type = "warning", duration = 5)
      } else {
        showNotification(paste("Analysis complete!", nrow(detections), "detections found."), 
                         type = "message", duration = 3)
      }
      
    }, error = function(e) {
      showNotification(paste("Error during analysis:", e$message), 
                       type = "error", duration = 10)
      cat("Error details:", e$message, "\n")
    })
  })
  
  # Display summary
  output$summary <- renderText({
    req(values$detections)
    
    if (is.null(values$detections) || nrow(values$detections) == 0) {
      return("No species detected above the specified confidence threshold.")
    }
    
    unique_species <- length(unique(values$detections$common_name))
    total_detections <- nrow(values$detections)
    max_confidence <- max(values$detections$confidence, na.rm = TRUE)
    
    paste(
      "Total detections:", total_detections, "\n",
      "Unique species:", unique_species, "\n",
      "Highest confidence:", round(max_confidence, 3), "\n",
      "Confidence threshold:", input$confidence_threshold
    )
  })
  
  # Display detections table
  output$detections_table <- DT::renderDataTable({
    req(values$detections)
    
    if (is.null(values$detections) || nrow(values$detections) == 0) {
      return(data.frame(Message = "No detections found"))
    }
    
    # Format the detections data for display
    display_data <- values$detections
    if ("confidence" %in% names(display_data)) {
      display_data$confidence <- round(display_data$confidence, 3)
    }
    if ("start_time" %in% names(display_data)) {
      display_data$start_time <- round(display_data$start_time, 2)
    }
    if ("end_time" %in% names(display_data)) {
      display_data$end_time <- round(display_data$end_time, 2)
    }
    
    DT::datatable(
      display_data,
      options = list(
        pageLength = 15,
        scrollX = TRUE,
        order = list(list(which(names(display_data) == "confidence") - 1, "desc"))
      ),
      rownames = FALSE
    )
  })
  
  # Display audio file information
  output$audio_info <- renderText({
    req(input$wav_file)
    
    file_info <- input$wav_file
    file_size_mb <- round(file_info$size / (1024^2), 2)
    
    paste(
      "Filename:", file_info$name, "\n",
      "File size:", file_size_mb, "MB\n",
      "Upload time:", Sys.time()
    )
  })
}

shinyApp(ui = ui, server = server)