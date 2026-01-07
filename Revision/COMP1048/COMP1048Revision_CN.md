# COMP1048: 数据库与接口 (2025-2026) 复习指南

基于 Matthew Pike 和 Yanwen Mao 的复习讲座。

## 1. 概览与考试形式

### 考试形式
*   **结构**: 回答 **所有三个** 问题。
    *   **Q1 - Web 编程** [15 分]
    *   **Q2 - 关系数据库设计、理论与 DBMS** [15 分]
    *   **Q3 - SQL 与 ER 设计** [20 分]
*   **权重**: 占最终成绩的 **50%**。
*   **时间**: **2 小时**。

### 考试内容
课程中涵盖的任何内容都可能出现在考试中，包括：
*   DBMS (数据库管理系统)
*   关系模型与代数
*   ER 图 (实体关系图)
*   规范化 (Normalization)
*   SQL 查询
*   HTML 和 CSS
*   Flask
*   ...等。

---

## 2. 模块内容：数据库

### 2.1 关系模型 (Relational Model)
*   **什么是数据库？**
    *   存储在计算机中的结构化数据集合，旨在便于快速搜索和检索。
*   **为什么我们需要它？**
    *   为了以一种允许轻松查询、更新、插入和删除且不影响数据完整性的格式存储数据。
    *   解决基于文件系统的问题：数据重复、数据依赖、格式不兼容以及缺乏安全性和并发控制。
*   **什么是 DBMS？**
    *   **定义**: 用于创建和管理数据库的系统软件 (例如 SQLite, MySQL, Oracle)。
    *   **功能**: 提供集中式数据管理，抽象存储细节，并确保数据的一致性、完整性、安全性和并发访问。
    *   **语言**:
        *   **DDL (数据定义语言)**: 定义数据结构 (例如 `CREATE`, `DROP`)。
        *   **DML (数据操作语言)**: 插入、更新、删除 (例如 `INSERT`, `UPDATE`)。
        *   **DCL (数据控制语言)**: 控制数据访问 (例如 `GRANT`, `REVOKE`)。
        *   **DQL (数据查询语言)**: 查询和报告数据 (例如 `SELECT`)。
    *   **三层架构 (Three-Schema Architecture)**:
        *   **外部层 (External Level)**: 以用户可以理解的方式表示数据 (用户视图)。
        *   **概念层 (Conceptual Level)**: 提供整个数据库的整体视图。
        *   **内部层 (Internal Level)**: 负责物理数据存储，优化存储和访问效率。
    *   **优势**: 数据独立性、并发控制、安全性与完整性、备份与恢复、查询优化。
*   **关系模型概念**:
    *   **Relations (关系/表)**, **Attributes (属性/列)**, **Domains (域/数据类型)**。
    *   **Relationship (关系)**, **Cardinality Ratio (基数比)**。
    *   **Keys (键)**: 候选键 (Candidate keys), 主键 (Primary keys), 外键 (Foreign keys)。
    *   **Integrity (完整性)**: 参照完整性 (Referential integrity)。
*   **关系代数 (Relational Algebra)**:
    *   **操作符**:
        *   **选择 (σ)**: 过滤行 (`SELECT ... WHERE ...`)。
        *   **投影 (π)**: 过滤列 (`SELECT column1, column2`)。
        *   **连接 (⨝)**: 组合表 (`JOIN ... ON ...`)。
        *   **集合操作**: 并集 (∪), 交集 (∩), 差集 (-)。
    *   **任务**: 根据问题描述编写关系代数表达式。

> **关键指标 (Key Metrics - 必考点)**:
> *   **Degree (度)**: 属性 (列) 的数量。
> *   **Cardinality (基数)**: 元组 (行) 的数量。

### 2.2 数据库设计 (Database Design)
#### ER 图 (ER Diagram)
*   **组件**:
    *   **Entity (实体)**: 现实世界的对象 (矩形)。
    *   **Relationship (关系)**: 实体之间的关联 (菱形)。
    *   **Attributes (属性)**: 特征/性质 (椭圆)。
    *   **Cardinality (基数)**: 1:1, 1:N, M:N。
*   **任务**: 根据问题描述绘制 ER 图。
    *   *技巧*: 识别名词 (实体/属性) 和动词 (关系)。

#### 规范化 (Normalization)
*   **什么是规范化？为什么我们需要它？** (减少冗余，避免异常)。
*   **函数依赖 (Functional Dependency)**: A → B (A 决定 B)。
*   **范式 (Normal Forms)**:
    *   **1NF**: 原子值 (没有重复组)。
    *   **2NF**: 1NF + 无部分依赖 (非主属性必须依赖于**整个**主键)。
    *   **3NF**: 2NF + 无传递依赖 (非主属性必须**仅**依赖于主键)。
*   **任务**: 将未规范化的数据转换为 3NF。

### 2.3 SQL 查询 (SQL Queries)
*   **DDL (数据定义语言)**:
    *   **CREATE TABLE**:
        ```sql
        CREATE TABLE Student (
            sID INTEGER PRIMARY KEY,
            sName VARCHAR(50) NOT NULL,
            sYear INTEGER DEFAULT 1
        );
        ```
    *   **DROP TABLE**: `DROP TABLE table_name;`
*   **DML (数据操作语言)**:
    *   **INSERT**: `INSERT INTO Student (sName, sYear) VALUES ('Joe', 2);`
    *   **UPDATE**: `UPDATE Student SET sName = 'John' WHERE sID = 1;`
    *   **DELETE**: `DELETE FROM Student WHERE sID = 3;`
    *   **SELECT**: `SELECT DISTINCT column FROM table WHERE condition;`
*   **高级查询**:
    *   **ORDER BY**: 对结果进行排序。默认为 `ASC` (升序)。可以按多列排序 (例如 `ORDER BY sYear DESC, sName ASC`)。
    *   **GROUP BY & HAVING**:
        *   `HAVING` 在聚合*之后*过滤组。
        *   *注意*: 你**不能**在 `HAVING` 子句中使用别名 (例如使用 `HAVING AVG(grade) >= 60`, 而不是 `HAVING avg_grade >= 60`)。
    *   **子查询**: 例如 `WHERE EXISTS (SELECT ...)` 或 `WHERE sID IN (SELECT ...)`。
    *   **连接**:
        *   `INNER JOIN`: 当两个表中都有匹配时返回行。
        *   `LEFT JOIN`: 返回左表中的所有行，以及右表中匹配的行 (如果没有匹配则为 NULL)。
*   **比较**: SQL 与关系代数之间的联系与区别。

### 2.4 事务 (Transactions)
*   **定义**: 被视为单个逻辑工作单元的一系列数据库操作。
*   **ACID 属性**:
    *   **原子性 (Atomicity)**: 全有或全无。
    *   **一致性 (Consistency)**: 数据库保持有效。
    *   **隔离性 (Isolation)**: 事务互不干扰。
    *   **持久性 (Durability)**: 永久保存。

#### SQL 查询中的常见错误 (来自测验)
1.  **语法错误**: 缺少逗号、分号；错误地将 `WHERE` 与 `GROUP BY` 一起使用。
2.  **排序错误**: 缺少 `ORDER BY`，列错误，或按字符串排序 (例如 "10" < "2")。
3.  **IS NULL**: 使用 `= NULL` 而不是 `IS NULL`。
4.  **NATURAL JOIN**: 当表没有公共属性时使用 (导致笛卡尔积) 或有非预期的公共属性。
5.  **CROSS JOIN**: 误用导致无意义的组合 (笛卡尔积)。
6.  **LEFT JOIN**: 错误使用导致额外的/错误的行。
7.  **INNER JOIN**: 条件不正确。
8.  **歧义名称**: 在连接中列名相同时未指定表前缀 (例如 `Student.ID`)。
9.  **聚合函数**: 混合聚合和列时缺少 `GROUP BY`；使用了错误的函数 (例如用 `SUM` 求平均值)。
    *   **状态码**: `200 OK` (成功), `404 Not Found` (未找到), `500 Internal Server Error` (服务器内部错误)。
*   **HTML**:
    *   HTML 语法 (标签, 属性)。
    *   **元素**: 图像 (`<img>`), 超链接 (`<a>`), 列表 (`<ul>`, `<ol>`), 表格 (`<table>`), 表单 (`<form>`, `<input>`)。
    *   **无障碍性 (Accessibility)**: 使用语义标签和属性（如图像的 `alt`）来帮助屏幕阅读器

## 3. 模块内容：接口 (Interfaces)

### 3.1 HTML 和 CSS
*   **URL (统一资源定位符)**: 指定互联网上资源的位置。
*   **HTTP (超文本传输协议)**:
    *   **定义**: 用于在客户端和服务器之间传输 Web 资源的协议。
    *   **特征**: 无状态且基于文本。遵循请求-响应模型。
    *   **状态码**:
        *   `200 OK`: 请求成功。
        *   `404 Not Found`: 资源未找到。
        *   `500 Internal Server Error`: 服务器错误。
        *   `503 Service Unavailable`: 服务器过载或停机。
        *   `418 I'm a teapot`: (愚人节玩笑)。
*   **HTML (超文本标记语言)**:
    *   **结构**: `<!DOCTYPE html>`, `<html>`, `<head>`, `<body>`。
    *   **元素**: 图像 (`<img src="..." alt="...">`), 链接 (`<a href="...">`), 列表 (`<ul>`, `<ol>`, `<li>`), 表格, 表单。
    *   **无障碍性**: 为图像使用 `alt` 属性有助于视障用户 (屏幕阅读器)。
*   **CSS (层叠样式表)**:
    *   **功能**: 控制 HTML 元素的外观。
    *   **语法**: `selector { property: value; }` (例如 `.rImportant { color: red; }`)。
*   **DOM (文档对象模型)**:
    *   **定义**: 代表 HTML 文档的树状 API。
    *   **渲染过程**:
        1.  解析 HTML 以构建 DOM 树。
        2.  将 CSS 样式应用于 DOM 节点。
        3.  布局渲染树 (Layouting)。
        4.  将像素绘制到屏幕上 (Painting)。

### 3.2 Web 应用程序
*   **技术**: Python, Flask, Jinja。
*   **概念**:
    *   **客户端-服务器模型 (Client-Server Model)**。
    *   **什么是 Web 应用程序？**
    *   **为什么我们需要 Web 应用程序？**
*   **Flask 代码结构**:
    ```python
    from flask import Flask, request
    app = Flask(__name__)

    @app.route('/process_form', methods=['POST'])
    def process_input():
        # POST 请求: 使用 request.form
        user_name = request.form.get("user_name")
        # GET 请求: 使用 request.args
        # user_id = request.args.get("id")

        if user_name:
            return f"Hello {user_name}"
        else:
            return "Hello there"

    if __name__ == "__main__":
        app.run(debug=True)
    ```
    *   **关键点**:
        *   `methods=['POST']` 是处理表单提交所必需的。
        *   使用 `request.form` 获取 POST 数据 (隐藏在 Body 中)。
        *   使用 `request.args` 获取 GET 数据 (在 URL 中可见)。

---

## 4. 如何准备

### 方法
*   教科书
*   讲座幻灯片
*   录音
*   实验练习
*   **模拟试题和历年试卷** (至关重要！)

---

# 详细复习笔记 (附录)

*(以下是供参考的详细复习笔记)*

## A. 关系模型与代数详情

### 1. 术语映射
| 关系模型 (正式) | 表格术语 (非正式) |
| :--- | :--- |
| **Relation (关系)** | **Table (表)** |
| **Attribute (属性)** | **Column (列)** |
| **Tuple (元组)** | **Row (行)** |
| **Domain (域)** | **Data Type (数据类型)** |

### 2. 关系代数操作
*   **选择 (σ)**: 水平过滤 (行)。SQL 中的 `WHERE`。
*   **投影 (π)**: 垂直过滤 (列)。SQL 中的 `SELECT DISTINCT`。
*   **笛卡尔积 (×)**: 将 R 的每一行与 S 的每一行组合。`CROSS JOIN`。
*   **并集 (∪)**: R 或 S 中的行。(需要并相容性)。
*   **交集 (∩)**: R 和 S 中都有的行。
*   **差集 (-)**: 在 R 中但不在 S 中的行。
*   **连接 (⨝)**: 积与选择的组合。
    *   **自然连接**: 基于同名属性连接。
    *   **Theta 连接**: 基于条件连接。

## B. 数据库设计详情

### 1. ER 图技巧
*   **识别实体**: 名词 (例如 Student, Course)。
*   **识别关系**: 动词 (例如 Enrolls, Teaches)。
*   **属性**: 描述性名词。
*   **弱实体**: 依赖于强实体 (双矩形)。
*   **M:N 关系**: 在物理设计中通常需要分解为两个 1:N 关系和一个关联实体 (连接表)。

### 2. 规范化步骤
*   **未规范化 -> 1NF**: 移除重复组/数组。使值原子化。
*   **1NF -> 2NF**: 移除 **部分依赖**。将仅依赖于复合主键 *一部分* 的属性移动到新表。
*   **2NF -> 3NF**: 移除 **传递依赖**。将依赖于其他非键属性的属性移动到新表。

## C. SQL 详情

### 1. 执行顺序 (思维模型)
1.  `FROM` & `JOIN` (获取数据)
2.  `WHERE` (过滤行)
3.  `GROUP BY` (分组行)
4.  `HAVING` (过滤组)
5.  `SELECT` (选择列)
6.  `ORDER BY` (排序)
7.  `LIMIT` (限制数量)

### 2. 连接可视化
*   **INNER JOIN**: A 和 B 的交集。
*   **LEFT JOIN**: A 的全部，加上匹配的 B (或 NULL)。

### 3. 事务 (ACID)
*   **Atomicity (原子性)**: 全有或全无。
*   **Consistency (一致性)**: 数据库保持有效。
*   **Isolation (隔离性)**: 事务互不干扰。
*   **Durability (持久性)**: 永久保存。

## D. Web 开发详情

### 1. HTML 表单
*   `GET`: 数据在 URL 中 (不安全，长度有限)。适用于搜索。
*   `POST`: 数据在 Body 中 (安全，无限制)。适用于提交数据。

### 2. Flask 结构
*   `app.py`: 主要逻辑，路由 (`@app.route`)。
*   `templates/`: 带有 Jinja2 的 HTML 文件 (`{{ var }}`, `{% block %}`)。
*   `static/`: CSS, JS, 图片。

### 3. Jinja2 继承
*   `base.html`: 定义结构和块 (`{% block content %}`)。
*   `child.html`: 继承基础 (`{% extends "base.html" %}`) 并填充块。
