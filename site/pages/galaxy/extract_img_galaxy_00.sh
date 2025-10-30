#!/bin/bash

# Base URL for raw GitHub files
BASE_URL="https://raw.githubusercontent.com/galaxyproject/training-material/main/topics/introduction/images"

# List of image files
images=(
  "galaxy-login.png"
  "galaxy_interface.png"
  "rename_history_old.png"
  "upload-data.png"
  "upload-box.png"
  "eye-icon.png"
  "fastq.png"
  "fastqc-out.png"
  "filter-fastq1.png"
  "rerun.png"
  "history_menu_extract_workflow.png"
  "intro_short_workflow_extract.png"
  "intro_short_workflow_list.png"
  "intro_short_run_workflow.png"
  "galaxy_interface_history_switch.png"
  "copy-dataset.gif"
)

# Create local folder
mkdir -p images

# Download each image
for img in "${images[@]}"; do
    wget -O "images/$img" "$BASE_URL/$img"
done

echo "All images downloaded to ./images/"
