# COMP1048: Databases and Interfaces (2025-2026) Revision

Based on the Revision Lecture by Matthew Pike and Yanwen Mao.

## 1. Overview & Exam Format

### Exam Format
*   **Structure**: Answer **all THREE** questions.
    *   **Q1 - Web Programming** [15 Marks]
    *   **Q2 - Relational DB Design, Theory and DBMS** [15 Marks]
    *   **Q3 - SQL and ER Design** [20 Marks]
*   **Weighting**: Worth **50%** of the final mark.
*   **Time**: **2 hours**.

### Exam Content
Anything covered in the course may come up in the exam, including:
*   DBMS
*   Relational model and algebra
*   ER Diagram
*   Normalization
*   SQL Queries
*   HTML and CSS
*   Flask
*   ...etc.

---

## 2. Module Content: Database

### 2.1 Relational Model
*   **What is Database?**
    *   A structured set of data held in computer storage, arranged for ease and speed of search and retrieval.
*   **Why we need it?**
    *   To store data in a format that allows easy query, update, insert, and delete without affecting data integrity.
    *   To solve problems of file-based systems: data duplication, data dependence, incompatible formats, and lack of security/concurrency control.
*   **What is DBMS?**
    *   **Definition**: System software for creating and managing databases (e.g., SQLite, MySQL, Oracle).
    *   **Function**: Provides centralized data management, abstracts storage details, and ensures data consistency, integrity, security, and concurrent access.
    *   **Languages**:
        *   **DDL (Data Definition Language)**: Defines data structure (e.g., `CREATE`, `DROP`).
        *   **DML (Data Manipulation Language)**: Inserts, updates, deletes (e.g., `INSERT`, `UPDATE`).
        *   **DCL (Data Control Language)**: Controls access to data (e.g., `GRANT`, `REVOKE`).
        *   **DQL (Data Query Language)**: Queries and reports on data (e.g., `SELECT`).
    *   **Three-Schema Architecture**:
        *   **External Level**: Represents data in a way that users can understand (User Views).
        *   **Conceptual Level**: Provides a holistic view of the entire database.
        *   **Internal Level**: Responsible for physical data storage, optimizing storage and access efficiency.
    *   **Advantages**: Data Independence, Concurrency Control, Security & Integrity, Backup & Recovery, Query Optimization.
*   **Relational Model Concepts**:
    *   **Relations (Tables)**, **Attributes (Columns)**, **Domains (Data Types)**.
    *   **Relationship**, **Cardinality Ratio**.
    *   **Keys**: Candidate keys, Primary keys, Foreign keys.
    *   **Integrity**: Referential integrity.
*   **Relational Algebra**:
    *   **Operators**:
        *   **Selection (σ)**: Filters rows (`SELECT ... WHERE ...`).
        *   **Projection (π)**: Filters columns (`SELECT column1, column2`).
        *   **Join (⨝)**: Combines tables (`JOIN ... ON ...`).
        *   **Set operators**: Union (∪), Intersection (∩), Difference (-).
    *   **Task**: Write relational algebra based on the problem description.

> **Key Metrics (必考点)**:
> *   **Degree**: Number of Attributes (Columns).
> *   **Cardinality**: Number of Tuples (Rows).

### 2.2 Database Design
#### ER Diagram
*   **Components**:
    *   **Entity**: Real-world objects (Rectangles).
    *   **Relationship**: Associations between entities (Diamonds).
    *   **Attributes**: Properties (Ovals).
    *   **Cardinality**: 1:1, 1:N, M:N.
*   **Task**: Draw ER diagram according to the problem description.
    *   *Tip*: Identify Nouns (Entities/Attributes) and Verbs (Relationships).

#### Normalization
*   **What is normalization? Why we need it?** (Reduce redundancy, avoid anomalies).
*   **Functional Dependency**: A → B (A determines B).
*   **Normal Forms**:
    *   **1NF**: Atomic values (no repeating groups).
    *   **2NF**: 1NF + No partial dependencies (non-prime attributes depend on the *whole* primary key).
    *   **3NF**: 2NF + No transitive dependencies (non-prime attributes depend *only* on the primary key).
*   **Task**: Convert unnormalized data into 3NF.

### 2.3 SQL Queries
*   **DDL (Data Definition)**:
    *   **CREATE TABLE**:
        ```sql
        CREATE TABLE Student (
            sID INTEGER PRIMARY KEY,
            sName VARCHAR(50) NOT NULL,
            sYear INTEGER DEFAULT 1
        );
        ```
    *   **DROP TABLE**: `DROP TABLE table_name;`
*   **DML (Data Manipulation)**:
    *   **INSERT**: `INSERT INTO Student (sName, sYear) VALUES ('Joe', 2);`
    *   **UPDATE**: `UPDATE Student SET sName = 'John' WHERE sID = 1;`
    *   **DELETE**: `DELETE FROM Student WHERE sID = 3;`
    *   **SELECT**: `SELECT DISTINCT column FROM table WHERE condition;`
*   **Advanced Querying**:
    *   **ORDER BY**: Sorts results. Default is `ASC` (ascending). Can sort by multiple columns (e.g., `ORDER BY sYear DESC, sName ASC`).
    *   **GROUP BY & HAVING**:
        *   `HAVING` filters groups *after* aggregation.
        *   *Note*: You **cannot** use aliases in the `HAVING` clause (e.g., use `HAVING AVG(grade) >= 60`, NOT `HAVING avg_grade >= 60`).
    *   **Subqueries**: e.g., `WHERE EXISTS (SELECT ...)` or `WHERE sID IN (SELECT ...)`.
    *   **Joins**:
        *   `INNER JOIN`: Returns rows when there is a match in both tables.
        *   `LEFT JOIN`: Returns all rows from the left table, and matched rows from the right (NULL if no match).
*   **Comparison**: Connection and differences between SQL and Relational Algebra.

### 2.4 Transactions
*   **Definition**: A sequence of database operations treated as a single logical unit of work.
*   **ACID Properties**:
    *   **Atomicity**: All or nothing.
    *   **Consistency**: Database remains valid.
    *   **Isolation**: Transactions don't interfere.
    *   **Durability**: Saved permanently.

#### Common Errors in SQL Queries (From Quiz)
1.  **Syntax Error**: Missing commas, semicolons; using `WHERE` with `GROUP BY` incorrectly.
2.  **Incorrect Ordering**: Missing `ORDER BY`, wrong column, or sorting by string (e.g., "10" < "2").
3.  **IS NULL**: Using `= NULL` instead of `IS NULL`.
4.  **NATURAL JOIN**: Using it when tables have no common attributes (results in Cartesian product) or unintended common attributes.
5.  **CROSS JOIN**: Misuse resulting in nonsensical combinations (Cartesian product).
6.  **LEFT JOIN**: Incorrect use resulting in extra/wrong rows.
7.  **INNER JOIN**: Incorrect conditions.
8.  **Ambiguous Names**: Not specifying table prefix (e.g., `Student.ID`) when columns have same names in joins.
9.  **Aggregate Function**: Missing `GROUP BY` when mixing aggregates and columns; using wrong function (e.g., `SUM` for average).
## 3. Module Content: Interfaces

### 3.1 HTML and CSS
*   **URL (Uniform Resource Locator)**: Specifies the location of a resource on the Internet.
*   **HTTP (Hypertext Transfer Protocol)**:
    *   **Definition**: Protocol for transferring web resources between client and server.
    *   **Characteristics**: Stateless & text-based. Follows a Request-Response model.
    *   **Status Codes**:
        *   `200 OK`: Request succeeded.
        *   `404 Not Found`: Resource not found.
        *   `500 Internal Server Error`: Server error.
        *   `503 Service Unavailable`: Server is overloaded or down.
        *   `418 I'm a teapot`: (April Fools' joke).
*   **HTML (HyperText Markup Language)**:
    *   **Structure**: `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>`.
    *   **Elements**: Images (`<img src="..." alt="...">`), Links (`<a href="...">`), Lists (`<ul>`, `<ol>`, `<li>`), Tables, Forms.
    *   **Accessibility**: Using `alt` attributes for images helps visually impaired users (screen readers).
*   **CSS (Cascading Style Sheets)**:
    *   **Function**: Controls the appearance of HTML elements.
    *   **Syntax**: `selector { property: value; }` (e.g., `.rImportant { color: red; }`).
*   **DOM (Document Object Model)**:
    *   **Definition**: Tree-like API representing HTML documents.
    *   **Rendering Process**:
        1.  Parsing HTML to build the DOM tree.
        2.  Applying CSS styles to DOM nodes.
        3.  Layouting the Render Tree.
        4.  Painting pixels to the screen.

### 3.2 Web Application
*   **Technologies**: Python, Flask, Jinja.
*   **Concepts**:
    *   The **Client-Server Model**.
    *   **What are Web applications?**
    *   **Why we need web applications?**
*   **Flask Code Structure**:
    ```python
    from flask import Flask, request
    app = Flask(__name__)

    @app.route('/process_form', methods=['POST'])
    def process_input():
        # POST request: use request.form
        user_name = request.form.get("user_name")
        # GET request: use request.args
        # user_id = request.args.get("id")

        if user_name:
            return f"Hello {user_name}"
        else:
            return "Hello there"

    if __name__ == "__main__":
        app.run(debug=True)
    ```
    *   **Key Points**:
        *   `methods=['POST']` is required for handling form submissions.
        *   Use `request.form` for POST data (hidden in body).
        *   Use `request.args` for GET data (visible in URL).

---

## 4. How to Prepare

### Approaches
*   Text book
*   Lecture slides
*   Recordings
*   Lab exercises
*   **Mock exam questions and Past exam papers** (Crucial!)

---

# Detailed Revision Notes (Appendix)

*(Below are detailed notes from previous revision material for reference)*

## A. Relational Model & Algebra Details

### 1. Terminology Mapping
| Relational Model (Formal) | Table Terminology (Informal) |
| :--- | :--- |
| **Relation** | **Table** |
| **Attribute** | **Column** |
| **Tuple** | **Row** |
| **Domain** | **Data Type** |

### 2. Relational Algebra Operations
*   **Selection (σ)**: Horizontal filtering (Rows). `WHERE` in SQL.
*   **Projection (π)**: Vertical filtering (Columns). `SELECT DISTINCT` in SQL.
*   **Cartesian Product (×)**: Combines every row of R with every row of S. `CROSS JOIN`.
*   **Union (∪)**: Rows in R or S. (Requires Union-compatibility).
*   **Intersection (∩)**: Rows in both R and S.
*   **Difference (-)**: Rows in R but not S.
*   **Join (⨝)**: Combination of Product and Selection.
    *   **Natural Join**: Joins on attributes with same name.
    *   **Theta Join**: Joins based on a condition.

## B. Database Design Details

### 1. ER Diagram Tips
*   **Identify Entities**: Nouns (e.g., Student, Course).
*   **Identify Relationships**: Verbs (e.g., Enrolls, Teaches).
*   **Attributes**: Descriptive nouns.
*   **Weak Entity**: Depends on a strong entity (Double rectangle).
*   **M:N Relationships**: Often need to be decomposed into two 1:N relationships with an associative entity (junction table) in the physical design.

### 2. Normalization Steps
*   **Unnormalized -> 1NF**: Remove repeating groups/arrays. Make values atomic.
*   **1NF -> 2NF**: Remove **Partial Dependencies**. Move attributes that depend only on *part* of a composite primary key to a new table.
*   **2NF -> 3NF**: Remove **Transitive Dependencies**. Move attributes that depend on other non-key attributes to a new table.

## C. SQL Details

### 1. Order of Execution (Mental Model)
1.  `FROM` & `JOIN` (Get data)
2.  `WHERE` (Filter rows)
3.  `GROUP BY` (Group rows)
4.  `HAVING` (Filter groups)
5.  `SELECT` (Choose columns)
6.  `ORDER BY` (Sort)
7.  `LIMIT` (Restrict count)

### 2. Joins Visualized
*   **INNER JOIN**: Intersection of A and B.
*   **LEFT JOIN**: All of A, plus matching B (or NULL).

### 3. Transactions (ACID)
*   **Atomicity**: All or nothing.
*   **Consistency**: Database remains valid.
*   **Isolation**: Transactions don't interfere.
*   **Durability**: Saved permanently.

## D. Web Development Details

### 1. HTML Forms
*   `GET`: Data in URL (insecure, limited length). Good for search.
*   `POST`: Data in Body (secure, no limit). Good for submitting data.

### 2. Flask Structure
*   `app.py`: Main logic, routes (`@app.route`).
*   `templates/`: HTML files with Jinja2 (`{{ var }}`, `{% block %}`).
*   `static/`: CSS, JS, Images.

### 3. Jinja2 Inheritance
*   `base.html`: Defines structure and blocks (`{% block content %}`).
*   `child.html`: Extends base (`{% extends "base.html" %}`) and fills blocks.
