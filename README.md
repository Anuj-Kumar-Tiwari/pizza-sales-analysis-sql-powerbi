<div align="center">

<img src="https://readme-typing-svg.demolab.com?font=Fira+Code&weight=600&size=28&pause=1000&color=FF6B35&center=true&vCenter=true&width=600&lines=🍕+Pizza+Sales+Analysis;SQL+%2B+Power+BI+Portfolio+Project;Turning+Raw+Data+into+Insights" alt="Typing SVG" />

<br/>

![PostgreSQL](https://img.shields.io/badge/PostgreSQL-316192?style=for-the-badge&logo=postgresql&logoColor=white)
![Power BI](https://img.shields.io/badge/Power_BI-F2C811?style=for-the-badge&logo=powerbi&logoColor=black)
![DAX](https://img.shields.io/badge/DAX-0078D4?style=for-the-badge&logo=microsoft&logoColor=white)
![CSV](https://img.shields.io/badge/Data-CSV-green?style=for-the-badge&logo=files&logoColor=white)

<br/>

> **Analyzed 21,350+ pizza orders using PostgreSQL & Power BI to uncover $817K in revenue insights, peak demand patterns, and product performance.**

<br/>

[![LinkedIn](https://img.shields.io/badge/Anuj_Kumar_Tiwari-0A66C2?style=flat-square&logo=linkedin&logoColor=white)](https://linkedin.com/in/anuj-kumar-tiwari-107704208)
[![GitHub](https://img.shields.io/badge/GitHub-Anuj--Kumar--Tiwari-181717?style=flat-square&logo=github)](https://github.com/Anuj-Kumar-Tiwari)
[![Email](https://img.shields.io/badge/Email-anuujji@gmail.com-EA4335?style=flat-square&logo=gmail&logoColor=white)](mailto:anuujji@gmail.com)

</div>

---

## 📌 Table of Contents

- [Project Overview](#-project-overview)
- [KPI Summary](#-kpi-summary)
- [Dataset](#-dataset)
- [SQL Queries](#-sql-queries)
- [Dashboard](#-power-bi-dashboard)
- [Key Insights](#-key-insights)
- [How to Run](#-how-to-run)
- [Tech Stack](#-tech-stack)

---

## 🎯 Project Overview

This is an **end-to-end data analysis project** on a fictional pizza restaurant's full year of sales data (2015). The objective was to extract meaningful KPIs and business insights using SQL, then present them through an interactive Power BI dashboard with slicers.

```
📦 Dataset      →    🛠️ PostgreSQL    →    📊 Power BI Dashboard
 4 CSV files         15 SQL Queries        Interactive KPI Report
 48,620 rows         Joins, Aggregations   Slicers, DAX Measures
```

---

## 💰 KPI Summary

<div align="center">

| 📊 Metric | 🔢 Value |
|:---|:---:|
| 💵 Total Revenue | **$817,860** |
| 🧾 Total Orders | **21,350** |
| 🍕 Total Pizzas Sold | **49,574** |
| 💳 Avg Order Value | **$38.31** |
| 📅 Avg Orders Per Day | **59.6** |
| 🍕 Avg Pizzas Per Order | **2.32** |

</div>

---

## 🗂️ Dataset

The dataset consists of **4 relational CSV files** representing a real-world pizza store schema:

```
orders.csv          →  order_id | date | time
order_details.csv   →  order_details_id | order_id | pizza_id | quantity
pizzas.csv          →  pizza_id | pizza_type_id | size | price
pizza_types.csv     →  pizza_type_id | name | category | ingredients
```

### 🔗 Table Relationships

```
┌─────────┐       ┌───────────────┐       ┌──────────┐       ┌─────────────┐
│ orders  │──────<│ order_details │>──────│  pizzas  │>──────│ pizza_types │
│ order_id│       │ order_id      │       │ pizza_id │       │pizza_type_id│
│ date    │       │ pizza_id      │       │ size     │       │ name        │
│ time    │       │ quantity      │       │ price    │       │ category    │
└─────────┘       └───────────────┘       └──────────┘       │ ingredients │
                                                              └─────────────┘
```

---

## 🛠️ SQL Queries

All **15 PostgreSQL queries** written in `Pizza_Sales_Project.sql`:

<details>
<summary><b>📋 Click to expand — Full Query List</b></summary>

<br/>

| # | Query | SQL Concepts Used |
|---|-------|-------------------|
| 1 | Total Revenue | `SUM`, `JOIN` |
| 2 | Total Orders | `COUNT DISTINCT` |
| 3 | Total Pizzas Sold | `SUM` |
| 4 | Average Order Value | `ROUND`, `SUM/COUNT` |
| 5 | Orders Per Day | `COUNT DISTINCT` |
| 6 | Top 5 Best-Selling Pizzas | `GROUP BY`, `ORDER BY`, `LIMIT` |
| 7 | Peak Hours | `EXTRACT(HOUR)`, `GROUP BY` |
| 8 | Revenue by Category | Multi-table `JOIN`, `GROUP BY` |
| 9 | Revenue by Size | `GROUP BY` on size |
| 10 | Monthly Revenue Trend | `EXTRACT(MONTH)`, `GROUP BY` |
| 11 | Bottom 5 Worst-Selling Pizzas | `ASC` sort + `LIMIT` |
| 12 | Daily Revenue Trends | `GROUP BY date` |
| 13 | Busiest Days of the Week | `TO_CHAR(date, 'Day')` |
| 14 | Average Orders Per Day | `COUNT/COUNT` ratio |
| 15 | Full Detail View | 4-table `JOIN`, `ROUND` |

</details>

<br/>

**Sample Query — Top 5 Best Sellers:**

```sql
SELECT
    pt.name,
    SUM(od.quantity) AS Total_Sold
FROM order_detail od
JOIN pizza p ON od.pizza_id = p.pizza_id
JOIN pizza_types pt ON pt.pizza_type_id = p.pizza_type_id
GROUP BY pt.name
ORDER BY Total_Sold DESC
LIMIT 5;
```

---

## 📊 Power BI Dashboard

The `Pizza_Sales_Dashboard.pbix` file contains a **multi-filter interactive dashboard** with:

### Visuals Included

| Visual | Chart Type | Insight |
|--------|-----------|---------|
| Monthly Revenue | Line Chart | Seasonal trends across 12 months |
| Orders by Day | Bar Chart | Friday is peak day (3,538 orders) |
| Peak Hours | Bar Chart | 12 PM–1 PM & 5 PM–7 PM are busiest |
| Revenue by Category | Donut Chart | Classic leads at 26.9% |
| Revenue by Size | Donut Chart | Large = 45.9% of total revenue |
| Top 5 Sellers | Horizontal Bar | Classic Deluxe = #1 (2,453 sold) |
| Bottom 5 Sellers | Horizontal Bar | Brie Carre = worst (490 sold) |

### Slicers / Filters
- 📅 Date Range
- 🍕 Pizza Category (Classic / Supreme / Chicken / Veggie)
- 📏 Pizza Size (S / M / L / XL / XXL)

---

## 💡 Key Insights

```
📅  BUSIEST DAY     →  Friday (3,538 orders — 13.3% of weekly total)
⏰  PEAK HOURS      →  12 PM–1 PM  &  5 PM–7 PM
🍕  TOP SELLER      →  The Classic Deluxe Pizza (2,453 units)
📉  WORST SELLER    →  The Brie Carre Pizza (490 units)
📏  BEST SIZE       →  Large (45.9% of revenue)
⚠️  REVIEW SIZE     →  XL + XXL combined = only 1.85% of revenue
📈  BEST MONTH      →  July ($72,558 revenue)
📉  WEAKEST MONTH   →  October ($64,028 revenue)
🏆  TOP CATEGORY    →  Classic ($220,053 — highest revenue)
```

---

## 🚀 How to Run

### Step 1 — PostgreSQL Setup

```bash
# 1. Create a new database
CREATE DATABASE pizza_sales;

# 2. Open Pizza_Sales_Project.sql in pgAdmin or psql
# 3. Update the COPY command paths to match your local folder:
```

```sql
COPY orders(order_id, date, time)
FROM 'C:/your-folder/orders.csv'
CSV Header;
```

```bash
# 4. Run full script → tables created, data loaded, all 15 queries execute
```

### Step 2 — Power BI Dashboard

```
1. Open Pizza_Sales_Dashboard.pbix in Power BI Desktop
2. Go to: Home → Transform Data → Data Source Settings
3. Update file paths to your local CSV folder
4. Click Refresh → Dashboard loads with live data
5. Use slicers to filter by date, category, and size
```

---

## 🗃️ Project Structure

```
📁 Pizza-Sales-Analysis/
│
├── 📁 Data/
│   ├── orders.csv               # 21,350 rows — order dates & times
│   ├── order_details.csv        # 48,620 rows — line items per order
│   ├── pizzas.csv               # 96 rows — pizza sizes & prices
│   └── pizza_types.csv          # 32 rows — pizza names & categories
│
├── 📄 Pizza_Sales_Project.sql   # 15 PostgreSQL queries
├── 📊 Pizza_Sales_Dashboard.pbix # Power BI interactive dashboard
└── 📝 README.md
```

---

## 🛠️ Tech Stack

<div align="center">

| Tool | Purpose |
|------|---------|
| ![PostgreSQL](https://img.shields.io/badge/-PostgreSQL-316192?logo=postgresql&logoColor=white&style=flat-square) | Data storage, table creation, KPI queries |
| ![Power BI](https://img.shields.io/badge/-Power%20BI-F2C811?logo=powerbi&logoColor=black&style=flat-square) | Interactive dashboard & data visualizations |
| **DAX** | KPI measures — Revenue, Avg Order Value, etc. |
| **Power Query** | Data transformation & loading |

</div>

---

## 📬 Connect with Me

<div align="center">

If you found this project useful, feel free to ⭐ **star the repo** and connect!

[![LinkedIn](https://img.shields.io/badge/LinkedIn-Anuj_Kumar_Tiwari-0A66C2?style=for-the-badge&logo=linkedin&logoColor=white)](https://linkedin.com/in/anuj-kumar-tiwari-107704208)
[![GitHub](https://img.shields.io/badge/GitHub-Anuj--Kumar--Tiwari-181717?style=for-the-badge&logo=github)](https://github.com/Anuj-Kumar-Tiwari)
[![Email](https://img.shields.io/badge/Gmail-anuujji@gmail.com-EA4335?style=for-the-badge&logo=gmail&logoColor=white)](mailto:anuujji@gmail.com)

<br/>

*Made with ❤️ by Anuj Kumar Tiwari — Data Analyst Portfolio Project*

</div>
