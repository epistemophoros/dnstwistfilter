#!/bin/bash

# Check if a website name is provided
if [ -z "$1" ]; then
    echo "Usage: $0 <website-name>"
    exit 1
fi

# Define the base name from the first argument
base_name="$1"

# Define the input and output file names based on the provided website name
input_file="phishing-${base_name}.txt"
active_file="phishing-${base_name}-active.txt"
unactive_file="phishing-${base_name}-unactive.txt"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file $input_file does not exist."
    exit 1
fi

# Prepare the output files by clearing existing ones or creating new ones
> "$active_file"
> "$unactive_file"

# Read through each line in the input file
while IFS= read -r line
do
    # Check if the line contains '!ServFail'
    if echo "$line" | grep -q "!ServFail"; then
        # If it does, append to the unactive file
        echo "$line" >> "$unactive_file"
    else
        # Otherwise, append to the active file
        echo "$line" >> "$active_file"
    fi
done < "$input_file"

