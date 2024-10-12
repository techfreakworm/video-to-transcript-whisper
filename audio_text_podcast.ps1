# Set the input and output directories
$inputDir = "C:\Users\Priya\video-to-transcript-whisper\podcast_audio"
$outputDir = "C:\Users\Priya\video-to-transcript-whisper\podcast_subs"

# Check if Whisper is installed
if (-not (Get-Command whisper -ErrorAction SilentlyContinue)) {
    Write-Host "Whisper could not be found. Please install Whisper before running this script."
    exit
}

# Create the output directory if it doesn't exist
if (-not (Test-Path $outputDir)) {
    New-Item -ItemType Directory -Path $outputDir | Out-Null
}

# Loop through all audio files in the input directory
Get-ChildItem -Path $inputDir -Filter *.* | ForEach-Object {
    $audioFile = $_.FullName

    if (Test-Path $audioFile) {
        # Get the base name of the audio file (without extension)
        $baseName = [System.IO.Path]::GetFileNameWithoutExtension($audioFile)
        
        # Set the output subtitle file path
        $outputFile = $outputDir
        
        # Run Whisper to generate the subtitle file with English language
        whisper $audioFile --language English --output_format srt --output_dir $outputFile
        
        Write-Host "Subtitles for $audioFile have been saved to $outputFile"
    }
}

Write-Host "All subtitles have been generated."
