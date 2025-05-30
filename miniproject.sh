#!/bin/bash

#Dynamic Data Ingestion and Hive Integration Script
# Author: GOKULARAJA R


#CONFIG
FILE_NAME="hu-est2001-cty_fips.csv"
CSV_URL="https://www2.census.gov/programs-surveys/popest/datasets/2000-2001/housing/totals/$FILE_NAME"
LOCAL_PATH="/home/gokulubuntu/mini_project/$FILE_NAME"
CLEAN_FILE="/home/gokulubuntu/mini_project/clean-$FILE_NAME"
HDFS_DIR="/user/project/dataset"
HDFS_PATH="$HDFS_DIR/$FILE_NAME"
HIVE_DB="mydatabase"
HIVE_TABLE="hu_estimates_2001"

#Download the CSV
echo "\n== Checking local CSV =="
if [ ! -f "$LOCAL_PATH" ]; then
  echo "File not found. Downloading..."
  wget "$CSV_URL" -O "$LOCAL_PATH" || { echo "Download failed."; exit 1; }
else
  echo "File already exists: $LOCAL_PATH"
fi

#Clean the CSV (remove header)
echo "\n== Cleaning CSV (removing header) =="
tail -n +2 "$LOCAL_PATH" > "$CLEAN_FILE"

#Upload to HDFS
echo "\n== Uploading to HDFS =="
hadoop fs -mkdir -p "$HDFS_DIR"
hadoop fs -put -f "$CLEAN_FILE" "$HDFS_PATH"

#Create Hive Managed Table
echo "\n== Creating Hive Managed Table =="
hive -e "CREATE DATABASE IF NOT EXISTS $HIVE_DB; \
USE $HIVE_DB; \
DROP TABLE IF EXISTS $HIVE_TABLE; \
CREATE TABLE $HIVE_TABLE (
  fips_code_state INT,
  fips_code_county INT,
  region INT,
  division INT,
  estimate_2001 BIGINT,
  estimate_2000 BIGINT,
  census_2000 BIGINT,
  area_name STRING
)
ROW FORMAT DELIMITED
FIELDS TERMINATED BY ','
STORED AS TEXTFILE;"

#Load Data Into Hive Table
echo "\n== Loading Data into Hive Table =="
hive -e "USE $HIVE_DB; LOAD DATA INPATH '$HDFS_PATH' INTO TABLE $HIVE_TABLE;"

#Preview Data
echo "\n== Previewing Hive Data =="
hive -e "USE $HIVE_DB; SELECT * FROM $HIVE_TABLE LIMIT 10;"

echo "\n*** Completed Hive Ingestion Workflow ***"
