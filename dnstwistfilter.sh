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
active_file="${base_name}-active.txt"
unactive_file="${base_name}-unactive.txt"
output_file="abuse_contacts_${base_name}.csv"

# Check if the input file exists
if [ ! -f "$input_file" ]; then
    echo "Error: Input file $input_file does not exist."
    exit 1
fi

# Prepare the output files by clearing existing ones or creating new ones
> "$active_file"
> "$unactive_file"
echo "Domain,AbuseEmail" > "$output_file"

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
        # Extract NS records
        ns_records=$(echo "$line" | grep -oP 'NS:\K[^; ]+')
        for ns in $ns_records; do
            # Extract domain from NS record
            domain=$(echo "$ns" | cut -d '.' -f2-)
            # Perform WHOIS lookup to get abuse email
            abuse_email=$(whois $domain | grep -i 'abuse' | grep -oP ':\K.*' | tr -d ' ' | head -1)
            if [ ! -z "$abuse_email" ]; then
                # Save domain and abuse email in CSV format
                echo "$domain,$abuse_email" >> "$output_file"
            fi
        done
    fi
done < "$input_file"
