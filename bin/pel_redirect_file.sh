#!/bin/sh
# Forward stderr and stdout to file
#!/bin/bash

# Check if a command and a file were provided
if [ "$#" -ne 2 ]; then
  echo "Usage: $0 <command> <output_file>"
  exit 1
fi

# Extract arguments
command="$1"
output_file="$2"

# Execute the command and redirect both stdout and stderr to the specified file
$command > "$output_file" 2>&1
