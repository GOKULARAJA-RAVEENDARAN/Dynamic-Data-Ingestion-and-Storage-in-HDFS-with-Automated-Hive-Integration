# Dynamic-Data-Ingestion-and-Storage-in-HDFS-with-Automated-Hive-Integration



**Project Overview**
This project focuses on automating data ingestion, storage, and integration with Hive, using Python, APIs, HDFS, and shell scripting. The primary goal is to fetch data from a specified link, store it in HDFS, and create a Hive table for efficient data visualization and querying.

**Technologies Used**
- Python
- HDFS (Hadoop Distributed File System)
- Hive
- Shell scripting
- API data retrieval tools (wget, curl)

**Problem Statement**
  
The project involves fetching data from Census Bureau Data, storing it in HDFS, and then creating a Hive table to enable querying and visualization.
The challenge is to automate this entire process efficiently.

**Approach**

- Verify accessibility and download capability from the provided link.
- Determine data structure (single or multiple files, structured or unstructured).
- If structured, analyze schema for Hive table creation.
- Download data using wget or curl and store it in HDFS using:
hadoop fs -put <filename> /path/to/hdfs
- Create Hive database & table using Hive CLI.
- Load data into Hive table using:
LOAD DATA INPATH '/path/to/hdfs' INTO TABLE hive_table_name;
- Validate data integrity using SELECT queries.

**Results**
Following this approach ensures successful data retrieval, storage, and visualization in Hive for better analytics. An optional automation script streamlines future ingestion.

**How to Run the Project**
- Install dependencies:
pip install pandas numpy pyhdfs
- Clone this repository:
git clone <repo-link>
- Navigate to the project folder:
cd hdfs-hive-data-ingestion
- Run the Python ingestion script:
python data_ingestion.py
- Execute Hive queries using:
SELECT * FROM hive_table_name LIMIT 10;



