# Zepto Inventory & Product Analysis Using SQL

## Project Overview

This project analyzes product-level inventory and pricing data from Zepto using SQL to uncover business insights related to stock availability, discount patterns, category inconsistencies, and inventory concentration.

The dataset contained real-world data quality issues where the same product appeared multiple times under different categories, prices, and weights. A major challenge in this project was correctly defining what actually represents a unique product.

Instead of identifying products using only product names, products were uniquely defined using:

```sql
Product = Product Name + Weight
```

This significantly improved grouping accuracy and reduced incorrect aggregations during analysis.

The project demonstrates practical SQL skills used in real-world retail and e-commerce analytics.

---

# Dataset Description

| Feature | Description |
|---|---|
| Dataset Name | Zepto Product Inventory Dataset |
| Total Records | 3732 rows |
| Total Columns | 9 columns |
| Data Type | Retail / E-commerce Inventory Data |
| Main Attributes | Product Name, Category, Price, Discount, Weight, Stock Availability |
| Tools Used | SQL, MySQL Workbench |

The dataset contains product-level inventory and pricing information
used to analyze stock availability, discount behavior, category inconsistencies,
and inventory concentration.

# Business Problem

The dataset contained several real-world inconsistencies:

* Same products appeared under multiple categories
* Similar products had multiple pricing combinations
* Product names alone produced incorrect grouping results
* Duplicate product records affected inventory calculations
* Stock availability patterns were difficult to analyze accurately

To improve analytical reliability:

* Duplicate records were identified and removed
* Product entities were redefined using product name + weight
* Inventory and stock analysis were standardized
* Category-level inconsistencies were measured quantitatively

This project focuses not only on writing SQL queries but also on solving practical business data problems.

---

# Key Analysis Performed

## Inventory & Stock Analysis

* Out-of-stock analysis across products and categories
* Category-wise stock availability evaluation
* High stockout product identification
* Inventory concentration analysis

## Pricing & Discount Analysis

* Category-wise discount analysis
* Relationship between discounts and stock availability
* High inventory value product identification
* Discount effectiveness evaluation

## Data Quality Analysis

* Duplicate record detection
* Multi-category product inconsistency analysis
* Product standardization using product name + weight
* Incorrect aggregation issue resolution

## Product Segmentation

* Demand segmentation using inventory value and stock availability
* High-demand product identification
* Premium inventory category analysis

---

# Key Insights

## Stock Availability Insights

* Approximately **12% of products were out of stock**
* The **Biscuits category showed the highest stockout rate (28%)**, despite having relatively lower discounts
* Several high-discount products were frequently unavailable, indicating potential high demand

## Data Quality Insights

* Around **70% inconsistency was identified in category mapping**, where identical products appeared under multiple categories
* Using only product names caused incorrect grouping and aggregation
* Defining products using **Product Name + Weight** significantly improved analytical accuracy

## Inventory Insights

High inventory value was concentrated in premium categories such as:

* Oil(Olive Oli)
* Ghee(Praakritik Natural Desi Gir Cow A2 Ghee)
* Premium grocery products

## Business Learning

Real-world data is rarely clean.

This project highlighted the importance of:

* Proper entity definition
* Data cleaning
* Duplicate handling
* Standardized grouping logic
* Reliable aggregation techniques

for generating accurate business insights.

---

# Example Analytical Outputs

## 1. Overall Out-of-Stock Percentage

```sql
SELECT
    (CAST(COUNT(*) AS DECIMAL(10,2)) /
    (SELECT COUNT(*) FROM zepto_v1)) * 100 AS out_of_stock_percentage
FROM zepto_v1
WHERE outOfStock = 'TRUE';
```

### Output

| Metric                  | Value |
| ----------------------- | ----- |
| Out-of-stock Percentage | 12%   |

---

## 2. Category-Wise Out-of-Stock Analysis

### Key Finding

| Category | Out-of-stock Percentage |
| -------- | ----------------------- |
| Biscuits | 28%                     |
| Snacks   | 22%                     |
| Dairy    | 18%                     |

### Business Insight

The Biscuits category experienced the highest stock shortages even without aggressive discounting, suggesting strong organic demand.

---

## 3. Category Mapping Inconsistency Analysis

### Key Finding

| Metric                               | Value |
| ------------------------------------ | ----- |
| Multi-category Product Inconsistency | 70%   |

### Business Insight

A large percentage of products appeared under multiple categories, making standard grouping unreliable.

The inconsistency percentage was identified by analyzing products that appeared under multiple categories despite having the same product name and weight combination.

Using only product names caused incorrect grouping and aggregation during analysis.

To improve analytical accuracy, products were uniquely defined as:

Product = Product Name + Weight

## 4. Inventory Value Analysis

### Key Finding

Premium grocery products such as:

* Oil
* Ghee
* Premium food products

contributed the highest inventory value.

### Business Insight

A significant portion of inventory investment was concentrated in high-value premium products.

# SQL Concepts Used

* SELECT Statements
* GROUP BY
* HAVING Clause
* Aggregate Functions
* CASE Statements
* Common Table Expressions (CTEs)
* Window Functions
* ROW_NUMBER()
* Data Cleaning
* Duplicate Removal
* Business Analytics
* Exploratory Data Analysis (EDA)

# Tools Used

* MySQL
* SQL
* MySQL Workbench
* Git & GitHub

# Project Structure

```text
zepto-inventory-analysis-sql/
│
├── README.md
├── zepto_analysis.sql
├── dataset/
│   └── zepto_v1.csv
├── screenshots/
│   ├── stock_analysis.png
│   ├── category_inconsistency.png
│   ├── inventory_analysis.png
│   └── segmentation_output.png
└── insights/
    └── business_insights.md
```

# Sample Business Problems Solved

## Problem 1

How many products are unavailable and which categories are most affected?

## Problem 2

Are discounts contributing to stock shortages?
### Insight

Products with higher discounts were frequently observed to have higher stockout occurrences, suggesting that aggressive discounting may increase product demand and lead to faster inventory depletion.

## Problem 3

Which products contribute the highest inventory value?

## Problem 4

How can inconsistent product mapping affect business reporting?

## Problem 5

How should products be uniquely identified for accurate analysis?

---

# Future Improvements

- Automated stock replenishment recommendations can be developed for high-demand products
- Low-stock and high-stock alert systems can be implemented to reduce inventory imbalance
- Demand forecasting models can be created for better inventory planning
- Discount effectiveness analysis can be expanded to improve pricing strategies
- Interactive dashboards can be developed for real-time inventory monitoring
- Seasonal purchasing patterns can be analyzed to improve stock allocation
- Product recommendation insights can be generated based on demand concentration
- Product categorization can be improved using advanced data standardization techniques

---

# Learning Outcome

This project helped strengthen my understanding of:

* Real-world data cleaning challenges
* Inventory and retail analytics
* Business-oriented SQL analysis
* Data standardization techniques
* Practical exploratory data analysis

More importantly, it demonstrated that successful analysis depends not only on writing queries, but also on correctly understanding the business entity and data structure.

---

# Author

GitHub: [https://github.com/yoga-3731](https://github.com/yoga-3731)

---

# Conclusion

This project demonstrates how SQL can be used beyond simple querying to solve practical business problems in retail and e-commerce analytics.

The analysis combined:

* Data cleaning
* Inventory analysis
* Business intelligence
* Product standardization
* Demand segmentation

to generate meaningful insights from messy real-world data.

It reflects practical analytical thinking rather than only technical query writing.
