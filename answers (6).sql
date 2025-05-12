-- Question 1: Achieving 1NF
-- Transforming the ProductDetail table into 1NF by ensuring each row represents a single product per order.

-- Original table: 
-- OrderID | CustomerName | Products
-- ---------------------------------------
-- 101     | John Doe     | Laptop, Mouse
-- 102     | Jane Smith   | Tablet, Keyboard, Mouse
-- 103     | Emily Clark  | Phone

-- Transformed table in 1NF:
CREATE TABLE ProductDetail_1NF (
    OrderID INT,
    CustomerName VARCHAR(255),
    Product VARCHAR(255)
);

-- Inserting data into the new table:
INSERT INTO ProductDetail_1NF (OrderID, CustomerName, Product)
VALUES
    (101, 'John Doe', 'Laptop'),
    (101, 'John Doe', 'Mouse'),
    (102, 'Jane Smith', 'Tablet'),
    (102, 'Jane Smith', 'Keyboard'),
    (102, 'Jane Smith', 'Mouse'),
    (103, 'Emily Clark', 'Phone');

-- The table now satisfies 1NF because each row contains atomic values.

-- Question 2: Achieving 2NF
-- Transforming the OrderDetails table into 2NF by removing partial dependencies.

-- Original table:
-- OrderID | CustomerName | Product  | Quantity
-- ---------------------------------------------
-- 101     | John Doe     | Laptop   | 2
-- 101     | John Doe     | Mouse    | 1
-- 102     | Jane Smith   | Tablet   | 3
-- 102     | Jane Smith   | Keyboard | 1
-- 102     | Jane Smith   | Mouse    | 2
-- 103     | Emily Clark  | Phone    | 1

-- Design after 2NF (splitting into two tables to remove partial dependency):
-- Table 1: Orders (OrderID, CustomerName)
-- Table 2: OrderDetails (OrderID, Product, Quantity)

-- Creating the Orders table:
CREATE TABLE Orders (
    OrderID INT PRIMARY KEY,
    CustomerName VARCHAR(255)
);

-- Inserting data into the Orders table:
INSERT INTO Orders (OrderID, CustomerName)
VALUES
    (101, 'John Doe'),
    (102, 'Jane Smith'),
    (103, 'Emily Clark');

-- Creating the OrderDetails table:
CREATE TABLE OrderDetails_2NF (
    OrderID INT,
    Product VARCHAR(255),
    Quantity INT,
    FOREIGN KEY (OrderID) REFERENCES Orders(OrderID)
);

-- Inserting data into the OrderDetails table:
INSERT INTO OrderDetails_2NF (OrderID, Product, Quantity)
VALUES
    (101, 'Laptop', 2),
    (101, 'Mouse', 1),
    (102, 'Tablet', 3),
    (102, 'Keyboard', 1),
    (102, 'Mouse', 2),
    (103, 'Phone', 1);

-- The tables now satisfy 2NF because non-key columns fully depend on the entire primary key.