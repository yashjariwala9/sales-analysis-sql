# Supermarket Analysis using SQL

## Overview
In this project, I have analyzed superstore sales data using SQL. Importing datasets into a PostgreSQL database and running different queries over it to find actionable insights on sales trends, customer behavior, product performance, shipping time, and location-wise / category-wise sales breakdown

## Features
- **Data Import**: Automate the import of CSV or Excel files into PostgreSQL tables using a python script.
- **SQL Queries**: Perform data analysis with prewritten SQL scripts.
- **Database Structure**: Create dynamic tables based on file headers.
- **Insights**: Analyze sales performance metrics and trends.
- **Insights List**: file name ```list.txt```

## Prerequisites
- **PostgreSQL**: Ensure you have PostgreSQL installed and configured.
- **Python**: running the import script.
- **Python Tool**: Install `pandas` if importing Excel files.
  ```bash
  pip install pandas
- **Kaggle Dataset Link (Superstore Sales) / Already Provided ```train.csv```**: https://www.kaggle.com/datasets/rohitsahoo/sales-forecasting
  
## Usage Instructions

- **Step 1: Import Data**: Run the provided `Script/import_table_from_csv.py` script to import your data file into PostgreSQL.
  ```bash
  python import_table_from_csv.py

- The script will:
    - prompt for database name, file path, and target table name.
    - Save Excel files in CSV Format (if necessary).
    - Make a table with the CSV headers.
    - Load data into the Postgres table.

- **Step 2: Analyze Data**: Use the ```sales_analysis.sql``` file to execute SQL queries from the PostgreSQL Desktop App.
