# ER Diagram

This folder contains the Entity Relationship Diagram (ERD) used to understand the data structure and relationships in the Lms dataset.

---

## 🧩 ER Relationship Model

The Power BI data model is based on a star-schema design:

- **Fact Table**: `Lms_Analysis.csv`  
- **Dimension Tables**: `Book_Details`, `Book_Issue`, `Fine_Details`, `Lms_Members`, `Suppliers_Details`

All dimension tables were connected through primary keys (e.g., `BOOK_CODE`, `MEMBER_ID`, `SUPPLIER_ID`) and merged into the final dataset.

---
