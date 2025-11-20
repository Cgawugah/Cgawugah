# National Housing Data Cleaning (SQL Project)

This project focuses on cleaning and preparing a national housing dataset using SQL.  
The raw dataset includes inconsistent date formats, missing address information, duplicates, and combined fields that make analysis difficult.  
The goal of this project is to transform the dataset into a clean, well-structured, and analysis-ready table using SQL Server.

The full cleaning process is contained in:

**National Housing Project.sql**

## Project Overview

This project demonstrates essential SQL data-cleaning techniques, including:
- Standardizing inconsistent data formats  
- Filling missing values using relational logic  
- Splitting combined fields into separate columns  
- Cleaning and normalizing categorical variables  
- Detecting and removing duplicate records  
- Dropping unused or redundant columns  

This workflow represents what a data analyst would typically perform when preparing raw real estate data for reporting and analysis.

## Data Cleaning Steps Performed

### 1. Standardizing Sale Date Format
The `SaleDate` column came in mixed formats.  
It was converted to a proper `DATE` data type and stored in a new column called `SaleDateConverted`.

### 2. Filling Missing Property Addresses
Some records were missing property addresses.  
Using a self-join on `ParcelID`, missing addresses were filled using values from matching rows that contained a valid address.

### 3. Splitting Address Fields
To improve clarity and filtering capability, full addresses were split into multiple columns.

Property address was separated into:
- `PropertySplitAddress`
- `PropertySplitCity`

Owner address was separated into:
- `OwnerSplitAddress`
- `OwnerSplitCity`
- `OwnerSplitState`

### 4. Cleaning the “SoldAsVacant” Column
Values such as `Y` and `N` were standardized to more readable categories:
- Yes  
- No  


### 5. Identifying Duplicate Records
A CTE with `ROW_NUMBER()` was used to detect duplicate entries based on:
- Parcel ID  
- Property Address  
- Sale Price  
- Sale Date  
- Legal Reference  

Any record with a row number greater than 1 was flagged as a duplicate.

### 6. Dropping Unused Columns
After cleaning and restructuring the data, unnecessary columns were removed, such as:
- `OwnerAddress`  
- `TaxDistrict`  
- `PropertyAddress`  
- `SaleDate`


