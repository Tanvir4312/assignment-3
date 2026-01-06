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
create type role_type as enum('Admin', 'Customer')

-- Enum for vehicle type and status
create type vehicle_type as enum('car', 'bike', 'truck')
create type status_type as enum('available', 'rented', 'maintenance')

-- Enum for booking status
create type bookingStatus_type as enum('pending', 'confirmed', 'completed', 'cancelled')



🔹 Users Table

Stores user information and their role in the system.
create table users(
  user_id serial primary key,
  name varchar(50),
  email varchar(100),
  password text,
  phone varchar(15),
  role role_type
);


🔹 Vehicles Table

Stores details of vehicles available for rent.
create table vehicles(
  vehicle_id serial primary key,
  name varchar(50),
  type vehicle_type,
  model int,
  registration_number varchar(100) unique,
  Rental_price int,
  status status_type
  );


🔹 Bookings Table

Stores booking information and links users with vehicles.
create table bookings(
  booking_id serial primary key,
  user_id int references users(user_id),
  vehicle_id int references vehicles(vehicle_id),
  start_date date,
  end_date date,
  status bookingStatus_type,
  total_cost numeric(8, 2)
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

