# DnsTwist Domain Sorter

This repository contains a Bash script designed to sort domain names based on their activity status from outputs generated by `dnstwist`. The script categorizes domains into "active" and "unactive" based on the presence of the `!ServFail` marker, which indicates DNS server failures. Additionally, for active domains, the script extracts NS records, performs WHOIS lookups to find abuse contact emails, and saves this information in a CSV file.

## Prerequisites

Before running this script, ensure you have:
- A Unix-like environment (Linux, macOS)
- Bash shell
- Access to the command line/terminal
- `whois` tool installed (for fetching abuse contact information)

## Installation

Clone this repository to your local machine using:
`git clone https://github.com/epistemophoros/dnstwistfilter.git && cd dnstwistfilter`

Make the script executable:
`chmod +x sort-phishing.sh`

## Usage

To use the script, you need to provide the base name of the website as a command-line argument. The script expects a file named `phishing-<website-name>.txt` in the same directory.

For example, if you have a file named `phishing-discord.txt`, you would run:
`./sort-phishing.sh discord`

This command will process the file and generate two output files:
- `<website-name>-active.txt` - contains domains considered active.
- `<website-name>-unactive.txt` - contains domains flagged with `!ServFail`.
- `abuse_contacts_<website-name>.csv` - contains a CSV list of domains and their corresponding abuse emails for active domains.

## Files

- `sort-phishing.sh`: The main script that processes the input file and sorts the domains.

## Contributing

Contributions to this project are welcome! Please fork the repository and submit a pull request with your enhancements. For major changes, please open an issue first to discuss what you want to change.

## Support

If you encounter any problems or have suggestions, please open an issue in the repository.
