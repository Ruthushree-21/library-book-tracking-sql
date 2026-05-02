# 📚 Library Book Tracking & Recommendation System

## 📌 Project Overview
This project is a SQL-based Library Management System designed to manage books, members, borrowing activities, and provide book recommendations based on user behavior.

It simulates a real-world library system used in schools, universities, and digital platforms.


##  Objective
- Track books and members in a library
- Manage borrowing and returning of books
- Identify overdue books
- Analyze reading patterns
- Provide book recommendations

---

##  Tools Used
- SQL Server (SSMS)
- Database Design
- SQL Queries
- ER Diagram

---

##  Database Schema

### Tables:
- authors
- categories
- books
- members
- borrow_records
- reviews


## 📊 Key Features

### 1. Book Management
- Add and store book details
- Track available copies

### 2. Borrow System
- Track issued books
- Auto update availability using triggers

### 3. Return System
- Update book availability after return

### 4. Overdue Detection
- Identify books not returned on time

### 5. Recommendation System
- Suggest books based on:
  - Category preference
  - Popular books
  - Highly rated books
## 📈 Key SQL Queries

- Fetch all books
- Borrow history per member
- Overdue books list
- Most borrowed books
- Top rated books
- Active members
##  Recommendation Logic
- Based on same category books
- Based on most borrowed books
- Based on user reading history
- Based on ratings
## Insights Generated
- Most popular books
- Most active readers
- Category-wise trends
- Reading behavior analysis
- Library usage patterns
## 🚀 How to Run
1. Open SQL Server Management Studio (SSMS)
2. Run `schema.sql`
3. Run `data.sql`
4. Run `queries.sql`
5. View outputs
## 📌 Conclusion
This project demonstrates how SQL can be used to build a real-world library management system with analytics and recommendation features.

It helps improve:
- Data management
- User engagement
- Decision making in libraries
