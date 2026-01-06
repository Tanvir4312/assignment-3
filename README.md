# 🚗 Vehicle Rental Management System (PostgreSQL)

## 📌 Project Description
This project is a **Vehicle Rental Management System** developed using **PostgreSQL**.  
It focuses on database design, ENUM usage, table relationships, and SQL queries to manage users, vehicles, and bookings efficiently.

The project demonstrates:
- Use of ENUM types for fixed-value columns
- Relational database design using foreign keys
- SQL queries using JOIN, GROUP BY, HAVING, and subqueries

---

## 🧱 Database Schema Design

### 🔹 ENUM Types
ENUM types are used to ensure data integrity by restricting column values.

```sql
-- Enum for user roles
CREATE TYPE role_type AS ENUM ('Admin', 'Customer');

-- Enum for vehicle type and status
CREATE TYPE vehicle_type AS ENUM ('car', 'bike', 'truck');
CREATE TYPE status_type AS ENUM ('available', 'rented', 'maintenance');

-- Enum for booking status
CREATE TYPE bookingStatus_type AS ENUM ('pending', 'confirmed', 'completed', 'cancelled');



🔹 Users Table

Stores user information and their role in the system.
CREATE TABLE Users (
  user_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  email VARCHAR(100),
  password TEXT,
  phone VARCHAR(15),
  role role_type
);


🔹 Vehicles Table

Stores details of vehicles available for rent.
CREATE TABLE vehicles (
  vehicle_id SERIAL PRIMARY KEY,
  name VARCHAR(50),
  type vehicle_type,
  model INT,
  registration_number VARCHAR(100) UNIQUE,
  rental_price INT,
  status status_type
);


🔹 Bookings Table

Stores booking information and links users with vehicles.
CREATE TABLE bookings (
  booking_id SERIAL PRIMARY KEY,
  user_id INT REFERENCES users(user_id),
  vehicle_id INT REFERENCES vehicles(vehicle_id),
  start_date DATE,
  end_date DATE,
  status bookingStatus_type,
  total_cost NUMERIC(8,2)
);


📊 SQL Queries and Explanations

All queries below are written according to the project requirements.

✅ Query 1: Retrieve booking information with customer and vehicle names

Requirement:
Retrieve booking information along with customer name and vehicle name.
SELECT 
  users.name AS user_name,
  vehicles.name AS vehicle_name,
  start_date,
  end_date,
  bookings.status
FROM bookings
INNER JOIN users USING (user_id)
INNER JOIN vehicles USING (vehicle_id);

Explanation:
Joins bookings with users and vehicles tables
Displays booking details with readable names

✅ Query 2: Find all vehicles that have never been booked

Requirement:
Retrieve vehicles that match the given condition.
SELECT *
FROM vehicles
WHERE NOT EXISTS (
    SELECT 1
    FROM vehicles AS v2
    WHERE v2.vehicle_id = vehicles.vehicle_id
      AND vehicles.status = 'rented'
);
Explanation:
Uses NOT EXISTS to filter vehicles
Excludes vehicles based on the specified condition


✅ Query 3: Retrieve all available vehicles of a specific type (cars)

Requirement:
Retrieve all available vehicles of type car.
SELECT *
FROM vehicles
WHERE type = 'car'
  AND vehicles.status = 'available';

Explanation:
Filters vehicles by type
Shows only vehicles that are currently available


✅ Query 4: Find vehicles with more than 2 bookings

Requirement:
Find the total number of bookings for each vehicle and display only those with more than two bookings.
SELECT 
  name AS vehicle_name,
  COUNT(*) AS total_bookings
FROM vehicles
INNER JOIN bookings USING (vehicle_id)
GROUP BY name
HAVING COUNT(*) > 2;

Explanation:
Groups booking records by vehicle
Uses HAVING to filter aggregated results

🛠 Technologies Used

PostgreSQL
ENUM Types
Relational Database Concepts

