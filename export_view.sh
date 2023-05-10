#!/bin/bash

# Default values
DB_HOST="dbwisee.cwjkkhwhfxrg.eu-west-3.rds.amazonaws.com"
DB_PORT="5432"
DB_NAME="dbwisee"
DB_USER="dbwisee_user_ai"
OUTPUT_FILE_PATH=$HOME/Documents/sedi_noesclusioni_latest.csv
FIELD_SEPARATOR="\t"

# Parse command-line options
while getopts "o:s:h:p:U:d:" opt; do
  case $opt in
    o) OUTPUT_FILE_PATH="$OPTARG";;
    s) FIELD_SEPARATOR="$OPTARG";;
    h) DB_HOST="$OPTARG";;
    p) DB_PORT="$OPTARG";;
    U) DB_USER="$OPTARG";;
    d) DB_NAME="$OPTARG";;
    \?)
      echo "Invalid option -$OPTARG" >&2
      exit 1;;
    :)
      echo "Option -$OPTARG requires an argument." >&2
      exit 1;;
  esac
done

# Export the contents of the view to a TSV file
psql -h "$DB_HOST" -p "$DB_PORT" -U "$DB_USER" \
  -d "$DB_NAME" -w \
  -c "\copy (SELECT * FROM sedi_noesclusioni_latest) to '$OUTPUT_FILE_PATH' with (format csv, delimiter E'$FIELD_SEPARATOR', header true, quote '\"')"

# Count the number of rows and columns in the output file
NUM_ROWS=$(awk -F"$FIELD_SEPARATOR" 'END{print NR}' $OUTPUT_FILE_PATH)
NUM_COLUMNS=$(awk -F"$FIELD_SEPARATOR" 'NR==1{print NF}' $OUTPUT_FILE_PATH)

# Check that the output file is not empty
if [ "$NUM_ROWS" -eq 0 ]; then
  echo "Error: Output file is empty."
  exit 1
fi


echo "Exported $NUM_ROWS rows and $NUM_COLUMNS columns to $OUTPUT_FILE_PATH"
