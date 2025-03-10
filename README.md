# Supermarket Analysis using SQL

## Overview
In this project, I have analyzed superstore sales data using SQL. Importing datasets into a PostgreSQL database and running different queries over it to find actionable insights on sales trends, customer behavior, product performance, shipping time, and location-wise / category-wise sales breakdown

## About Data
The data contains 18 columns and 9800 rows:
| Column         | Description                              | Data Type  |
|----------------|------------------------------------------|------------|
| Row ID         | Unique identifier for each row           | Integer    |
| Order ID       | Unique identifier for each order         | Text       |
| Order Date     | Date the order was placed                | Date       |
| Ship Date      | Date the order was shipped               | Date       |
| Ship Mode      | Shipping method used (e.g., Second Class)| Text       |
| Customer ID    | Unique identifier for the customer       | Text       |
| Customer Name  | Name of the customer                     | Text       |
| Segment        | Customer segment (e.g., Consumer)        | Text       |
| Country        | Country of the customer                  | Text       |
| City           | City of the customer                     | Text       |
| State          | State of the customer                    | Text       |
| Postal Code    | Postal code of the customer’s location   | Integer    |
| Region         | Region of the customer (e.g., South)     | Text       |
| Product ID     | Unique identifier for the product        | Text       |
| Category       | Product category (e.g., Furniture)       | Text       |
| Sub-Category   | Product sub-category (e.g., Bookcases)   | Text       |
| Product Name   | Name of the product                      | Text       |
| Sales          | Sales amount for the order               | Numeric    |

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

## Business Q&A

### Sales Performance

1. What were the top 3 highest selling months?  
2. What were the top 3 highest selling years?  
3. How much were the total regional sales?  

### Product Performance

1. What were the top 3 performing products in each region?  
2. What were the top 3 performing products in a particular region?  

### Customer Behavior Analysis

1. Who are the top 10 customers with the highest purchasing power?  
2. How do repeat customers compare to one-time customers?  
3. What is the Average Order Value (AOV) per customer?  
4. How is customer segmentation categorized?  

### Category-Wise Sales Breakdown

1. What are the top 3 highest selling product categories?  
2. What are the top 3 highest selling sub-categories?  

### Location-Wise Sales Breakdown

1. Which are the top 3 highest selling countries?  
2. What are the top 3 highest selling states?  
3. How is the order count distributed by city? 
4. How is the order count distributed by state?  
4. Which are the top 3 highest selling cities?  

### Shipping Time Analysis

1. How are ship modes categorized by speed and cost?  
2. How many orders were placed under different shipping speeds?  
3. Which cities had the most same-day orders?  
4. What is the distribution of ship modes by city?  
5. How is delivery time calculated?  
6. Which cities or regions experienced late deliveries?  
7. Which shipping modes are the fastest and most efficient?
