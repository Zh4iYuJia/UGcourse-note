-- ==========================================
-- SQL 考试复习标准模板 (Standard SQL Template)
-- ==========================================

-- 1. 环境设置 (Environment Settings)
.headers ON       -- 显示列名
.mode column      -- 以列模式显示输出，更整齐

-- 开启外键约束支持 (SQLite特有，考试常用)
PRAGMA foreign_keys = ON;

-- ==========================================
-- 2. 建表与删除 (DDL - Create & Drop)
-- ==========================================

-- 如果表存在则删除，防止报错 (Drop table if exists)
DROP TABLE IF EXISTS MovieSales;
DROP TABLE IF EXISTS Movies;
DROP TABLE IF EXISTS Actors;

-- 创建主表 (Create Parent Table)
CREATE TABLE Actors (
    actID INTEGER PRIMARY KEY,      -- 整数主键
    actName TEXT NOT NULL,          -- 文本，不能为空
    actGender TEXT CHECK (actGender IN ('M', 'F')), -- 检查约束
    actBirthYear INTEGER DEFAULT 2000 -- 默认值
);

-- 创建子表 (Create Child Table with Foreign Key)
CREATE TABLE Movies (
    movID INTEGER PRIMARY KEY,
    movTitle TEXT NOT NULL,
    movPrice REAL CHECK (movPrice >= 0), -- 实数，检查价格非负
    movYear INTEGER,
    movGenre TEXT,
    actID INTEGER, -- 外键列
    -- 定义外键约束，级联更新和删除
    FOREIGN KEY (actID) REFERENCES Actors(actID)
        ON UPDATE CASCADE
        ON DELETE CASCADE
);

-- 创建关联表/其他表
CREATE TABLE MovieSales (
    saleID INTEGER PRIMARY KEY,
    movID INTEGER,
    region TEXT,
    salesAmount INTEGER,
    FOREIGN KEY (movID) REFERENCES Movies(movID)
);

-- ==========================================
-- 3. 插入数据 (DML - Insert)
-- ==========================================

-- 插入多行数据
INSERT INTO Actors (actID, actName, actGender, actBirthYear) VALUES
    (1, 'Leonardo DiCaprio', 'M', 1974),
    (2, 'Scarlett Johansson', 'F', 1984),
    (3, 'Robert Downey Jr.', 'M', 1965);

INSERT INTO Movies (movID, movTitle, movPrice, movYear, movGenre, actID) VALUES
    (101, 'Inception', 12.99, 2010, 'Sci-Fi', 1),
    (102, 'Titanic', 9.99, 1997, 'Romance', 1),
    (103, 'Avengers', 15.50, 2012, 'Action', 3),
    (104, 'Lucy', 8.99, 2014, 'Sci-Fi', 2);

INSERT INTO MovieSales (movID, region, salesAmount) VALUES
    (101, 'US', 50000),
    (101, 'UK', 30000),
    (103, 'US', 80000),
    (103, 'CN', 90000);

-- ==========================================
-- 4. 数据更新与删除 (DML - Update & Delete)
-- ==========================================

-- 更新数据
UPDATE Movies
SET movPrice = movPrice * 1.1
WHERE movGenre = 'Sci-Fi';

-- 删除数据
DELETE FROM Movies
WHERE movYear < 1990;

-- ==========================================
-- 5. 查询语句 (DQL - Select)
-- ==========================================

-- --- 基础查询 (Basic Select) ---
SELECT * FROM Movies; -- 查询所有列

-- 带别名和排序 (Alias & Order By)
SELECT movTitle AS "Movie Title", 
       movYear AS "Year"
FROM Movies
ORDER BY movYear DESC, movTitle ASC; -- 先按年份降序，再按标题升序

-- --- 限制返回行数 (Limit) ---
SELECT * FROM Movies
LIMIT 5; -- 只显示前5行

SELECT * FROM Movies
ORDER BY movPrice DESC
LIMIT 3; -- 显示价格最高的前3个

-- --- 条件查询 (Where Clause) ---
-- 比较运算符: =, >, <, >=, <=, <>, !=
-- 逻辑运算符: AND, OR, NOT
-- 范围/集合: BETWEEN, IN
SELECT * FROM Movies
WHERE (movGenre = 'Action' OR movGenre = 'Sci-Fi')
  AND movPrice > 10.00;

SELECT * FROM Movies
WHERE actID IN (1, 3); -- 在集合中

-- --- 聚合函数 (Aggregates) ---
-- COUNT, SUM, AVG, MAX, MIN
-- ROUND(value, decimal_places)
SELECT COUNT(*) AS "Total Movies",
       AVG(movPrice) AS "Average Price",
       ROUND(MAX(movPrice), 2) AS "Max Price" 
FROM Movies;

-- --- 分组与过滤 (Group By & Having) ---
-- WHERE 在分组前过滤，HAVING 在分组后过滤
SELECT movGenre, 
       COUNT(*) AS "Count", 
       AVG(movPrice) AS "AvgPrice"
FROM Movies
GROUP BY movGenre
HAVING COUNT(*) >= 1; -- 只显示数量大于等于1的类别

-- --- 字符串操作 (String Operations) ---
-- 拼接 (Concatenation ||), 长度 (LENGTH)
SELECT movTitle || ' (' || movYear || ')' AS "Full Title",
       LENGTH(movTitle) AS "Title Length"
FROM Movies;

-- --- 类型转换 (Casting) ---
SELECT CAST(movYear AS INTEGER) FROM Movies;

-- ==========================================
-- 6. 多表连接 (Joins)
-- ==========================================

-- --- 内连接 (Inner Join) ---
-- 只返回两个表中匹配的行
SELECT m.movTitle, a.actName
FROM Movies m
JOIN Actors a ON m.actID = a.actID;

-- --- 左连接 (Left Join) ---
-- 返回左表所有行，右表不匹配则为NULL
SELECT a.actName, m.movTitle
FROM Actors a
LEFT JOIN Movies m ON a.actID = m.actID;

-- ==========================================
-- 7. 子查询 (Subqueries)
-- ==========================================

-- --- WHERE 子句中的子查询 ---
SELECT movTitle
FROM Movies
WHERE actID IN (
    SELECT actID FROM Actors WHERE actName LIKE 'Leonardo%'
);

-- --- FROM 子句中的子查询 (派生表) ---
SELECT sub.Genre, sub.AvgPrice
FROM (
    SELECT movGenre AS Genre, AVG(movPrice) AS AvgPrice
    FROM Movies
    GROUP BY movGenre
) AS sub
WHERE sub.AvgPrice > 10;

-- ==========================================
-- 8. 集合操作 (Set Operations)
-- ==========================================

-- UNION (去重合并)
SELECT movGenre FROM Movies
UNION
SELECT 'Total' AS movGenre;

-- ==========================================
-- 9. 复杂查询示例 (Complex Example)
-- ==========================================
-- 查找每个地区销售额最高的电影
SELECT ms.region, m.movTitle, MAX(ms.salesAmount)
FROM MovieSales ms
JOIN Movies m ON ms.movID = m.movID
GROUP BY ms.region;