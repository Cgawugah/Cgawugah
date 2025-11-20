**Navigating Growth Through the Years**

**Adventure Works Sales Analytics – Power BI Report**

This project is a complete end-to-end sales analytics dashboard built using Power BI, leveraging the Adventure Works dataset to uncover insights about revenue performance, product profitability, and regional contributions over multiple years. The report transforms raw data into clear, actionable visuals designed to support strategic decision-making.

**Project Overview**

The goal of this report is to analyze sales, revenue trends, profit margins, and year-over-year performance across products, regions, and sales personnel.
The dashboard provides an interactive interface that allows business users to explore company growth and identify performance opportunities over time.

**Data Model**

The data model follows a star schema structure optimized for analytical reporting.

**Fact Table**
**Sales**
This table contains transaction-level details including OrderDate, ProductKey, EmployeeKey, SalesTerritoryKey, Quantity, Cost, Total Sales, ResellerKey and other sales-related fields.

**Dimension Tables
Products**
Contains product details such as category, subcategory, color, standard cost, and metadata.

**Salesperson**
Includes information on employees associated with sales transactions.

**Region**
Contains country, region, and sales territory information.

**Key Measures**
Includes created measures such as Profit and other KPIs used throughout the report.

Relationships between these tables are established through primary keys including ProductKey, EmployeeKey and SalesTerritoryKey, allowing efficient filtering and slicing in the dashboard.

**Dashboard Features and Insights**

The dashboard highlights the following main performance indicators:

Profit: 45.81K
Revenue: 3.51M
Revenue Year over Year Percentage: 20.73 percent
Profit Margin: 1.31 percent

These metrics provide a quick overview of the company’s performance.

**Yearly Revenue Breakdown**

The dashboard displays revenue trends across years, including revenue compared to the previous year and percentage changes.

**Key findings observed include:**

From 2017 to 2019, Adventure Works experienced strong growth, with an increase of approximately 86 percent in sales.
From 2019 to 2020, there was a significant decline of approximately 50 percent. This highlights a potential market shift or operational challenge.
Despite the overall revenue growth of 21 percent, the profit margin remains low at 1.31 percent, suggesting high costs or low product profitability.

**Tools and Technologies Used**

Power BI Desktop
DAX
Star Schema Data Modeling
Adventure Works Dataset

**Project Structure**

Adventure Works Sales Analytics
PowerBI
Sales_Report.pbix
README.md
data_model_screenshots.png (optional)

**Skills Demonstrated**

Data cleansing and modeling
Designing and implementing star schema models
Creating calculated columns and DAX measures
Developing interactive dashboards
Extracting business insights
Communicating insights through data visualization

**Screenshots**

Data model showing fact and dimension table relationships
Dashboard pages displaying KPIs, yearly comparisons, and trend visuals
Product table with product attributes and cost information


**Future Improvements**

Adding drill-through pages for products, regions, and salespersons
Implementing forecasting features
Introducing parameters for simulation and scenario analysis
Applying Row Level Security for role-based access

**Contributions**

Contributions, issues, and feature suggestions are welcome.
Users are encouraged to open a pull request or submit an issue in the repository.
