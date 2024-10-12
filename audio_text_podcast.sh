#!/bin/bash

# Set the input and output directories
INPUT_DIR="/Users/techfreakworm/Projects/lab_notebooks/Chitkara/Unit-1 Podcasts"
OUTPUT_DIR="/Users/techfreakworm/Projects/lab_notebooks/Chitkara/subs"

# Check if Whisper is installed
if ! command -v whisper &> /dev/null
then
    echo "Whisper could not be found. Please install Whisper before running this script."
    exit
fi

# Create the output directory if it doesn't exist
mkdir -p "$OUTPUT_DIR"

# Loop through all audio files in the input directory
for audio_file in "$INPUT_DIR"/*
do
    if [[ -f "$audio_file" ]]; then
        # Get the base name of the audio file (without extension)
        base_name=$(basename "$audio_file" | cut -d. -f1)
        
        # Set the output subtitle file path
        output_file="$OUTPUT_DIR"
        
        # Run Whisper to generate the subtitle file with English language
        whisper "$audio_file" --language English --output_format srt --output_dir "$output_file"
        
        echo "Subtitles for $audio_file have been saved to $output_file"
    fi
done

echo "All subtitles have been generated."

