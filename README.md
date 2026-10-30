# Online Retail Performance & Customer Churn Analytics Dashboard
## Project Overview
This project simulates a real world analytics engagement for a fictional UK based gifting and home decor ecommerce brand, Online Retail / Gifting Store. The goal was to take raw, messy transactional data all the way through to a decision ready business intelligence dashboard, using the same workflow a data analyst would follow inside a real company: define the business problem first, clean and validate the data in SQL or build the analytical logics, and deliver the insight through an interactive Power BI report.
## MY Approach & Mindset
Most beginner projects focus purely on making charts. I reversed that. I focused on solving a real business problem end-to-end.

● Business First Mindset: Before writing queries or designing visuals, I defined the core business metrics (Revenue, Customer Retention,  Churn %, and Avg Customer Value) to ensure every chart directly supports executive decision making.

● Solving Real Data Quality Issues: Instead of using pre cleaned datasets, I handled raw transaction logs containing real world flaws in MySQL including duplicate records, cancelled orders, missing Customer IDs, and invalid negative quantities.

● Streamlined Executive Delivery: I transformed raw data into clean database views ("vw_page1_master") and built a bookmark driven Power BI dashboard, enabling seamless toggling between Customer and Revenue views without cluttering the screen.
## Business Problem
The business wants to identify its most valuable customers and reduce churn among customers who are at risk of leaving. Leadership currently has no structured view of customer value, so retention efforts are reactive instead of targeted.
## Business Questions 
● Who are our most valuable customers, and how much revenue do they actually contribute?

● Which customers have gone quiet and are at risk of churning?

● How does customer value and retention trend across time, by month, quarter, and year?

● How does customer value and churn differ across geographic markets?

● What specific, concrete actions should the business take for each customer segment? 
## Key Findings
● Seasonal Revenue Spikes: Sales data reveals strong seasonal spikes in Quarter4 (Holiday/Gifting season), which directly aligns with the gifting focused nature of the e-commerce store.

● Overall churn sits at 33.39% (90 day inactivity threshold), indicating retention is a significant, not marginal, business risk.

● Average customer value varies sharply by segment, from a few hundred for Lost customers to several thousand for Champions.

● Revenue shows clear seasonal spikes in Quarter4, consistent with a gifting focused product category.
## Tools and Tech Stack
| Tools | Purpose in this project |
|---|---|
| MySQL Workbanch       |     Data import, cleaning, deduplication, and exploratory querying on the 500K+ rows dataset      |
| Power BI Desktop      |     Two pages interactive dashboard: executive summary 
| DAX Measures          |     Measures for customer counts, revenue totals, Churned% and average customer value

## Core Concepts Demonstrated
● Business Logic & Churn Modeling: Applied a 90-day fixed inactivity threshold in SQL to dynamically flag churned vs. active customers.

● Advanced Data Cleaning in SQL: Resolved real world transactional data quality flaws, including duplicate records, cancelled orders ("C" codes), missing customer identifiers, and negative pricing/quantity errors.

● Database View Engineering ("vw_page1_master"): Built a optimized, single unified analytical view in MySQL to streamline report performance and eliminate redundant table joins in Power BI.

● Interactive UI/UX Design in Power BI: Implemented dynamic slicers, bookmark based visual toggles (Customer vs Revenue), custom KPI cards, and smooth next page navigation buttons.

## Dashboard Structure & Layout
● Page 1 — Home: Features the project title, clean page navigation buttons (Next Page), and an interactive Glossary defining core business metrics (Total Customers, Total Revenue, Churned% and Avg Customer Value).
● Page 2 — Business Overview:
  ● **Top Filter Panel (Slicers):** Dynamic slicers for filtering by Month, Quarter, Year, Country, and Churn status.
  ● **Headline KPIs:** Total Customers, Total Revenue, Churn %, and Average Customer Value.
  ● **Dynamic Bookmark Toggles:** Seamlessly switches between **Customer Dynamics** **Revenue Performance** and views on a single screen without cluttering.
  ● **Trend & Segment Views:** Multi attribute time series breakdowns across Month, Quarter, Year, and Country.
