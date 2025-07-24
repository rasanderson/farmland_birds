# How to use birdnetR with a .tflite custom model
library(birdnetR)
classifier_folder <- "checkpoints/custom"
classifier_name <- "Custom_Classifier"
model <- birdnet_model_custom("v2.4", classifier_folder = classifier_folder, classifier_name = classifier_name)
audio_path <- "train_data/Junco hyemalis_Dark-eyed Junco/XC11854_02.flac"
predictions <- predict_species_from_audio_file(model, audio_path)
predictions
