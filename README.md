# Supply Chain Management System

This project presents an end-to-end analysis of a supply chain system using **Tableau**, **SQL**, and **Machine Learning (Python)**. It includes interactive dashboards, data preprocessing, SQL queries, and a predictive model to forecast order volumes.

---

## Project Overview

- **Tools Used:** Tableau, MySQL, Python (Google Colab)
- **Dashboards Created:**
  - Orders Dashboard
  - Customers Dashboard
  - Payments Dashboard
  - Products Dashboard
  - Overview Dashboard

- **Data Sources:** CSV files for:
  - Orders
  - Customers
  - Payments
  - Products
  - Order Items

- **Filters Used:**  
  - Product Category  
  - Weekdays  
  - Brazil States  
  - Seller ID  
  - Payment Type

- **ML Model:**  
  Forecasts daily order volume using features such as shipping value, price, payment installments, etc. (Polynomial Regression)

---

##  Tableau Public

> Don’t have Tableau Desktop? You can still view the interactive dashboards at:

 [View on Tableau Public](https://public.tableau.com/app/profile/sanya.sharma4344/viz/SupplyChainManagementSystemTableaufile/D3-Overview?publish=yes)

---

## ML Overview

A separate Jupyter Notebook (`.ipynb`) is provided for predictive modeling.  
It includes:
- Data preprocessing  
- Model training using **Polynomial Regression**  
- Evaluation using **Mean Squared Error** and **R² Score**  
- Visualizations (scatter plot, trend comparison)

---

## Key Features

- End-to-end data visualization using Tableau
- Calculated Fields used in Tableau instead of Excel formulas
- SQL used for table creation, joins, aggregations, and filters
- Predictive model to forecast order volumes (using Python)
- Filters for customized insights

---

## ⚙How to Use

1. Clone the repository.
2. Open the Tableau `.twb` file to explore dashboards.
3. Launch the Python notebook on [Google Colab](https://colab.research.google.com/) or Jupyter.
4. Run the SQL script in your local MySQL server or tool.

---

## License

This project is licensed under the [MIT License](LICENSE).

---
