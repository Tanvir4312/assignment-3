

-- Enum
create type role_type as enum('Admin', 'Customer')

--  Create users table 
create table Users(
  user_id serial primary key,
  name varchar(50),
  email varchar(100),
  password text,
  phone varchar(15),
  role role_type
);

-- Enum
create type vehicle_type as enum('car', 'bike', 'truck')
create type status_type as enum('available', 'rented', 'maintenance')

--   Create vehicles table
create table vehicles(
  vehicle_id serial primary key,
  name varchar(50),
  type vehicle_type,
  model int,
  registration_number varchar(100) unique,
  Rental_price int,
  status status_type
  );

-- Enum
create type bookingStatus_type as enum('pending', 'confirmed', 'completed', 'cancelled')
  
  --   Create bookings table
create table bookings(
  booking_id serial primary key,
  user_id int references users(user_id),
  vehicle_id int references vehicles(vehicle_id),
  start_date date,
  end_date date,
  status bookingStatus_type,
  total_cost numeric(8, 2)
  );




-- Requirement: Retrieve booking information along with Customer name and Vehicle name.

    -- Queries - 1
select users.name as user_name, vehicles.name as vehicle_name, start_date, end_date, bookings.status from bookings
inner join users
using (user_id)
inner join vehicles
using(vehicle_id);


-- Requirement: Find all vehicles that have never been booked.

    -- Queries - 2
select * from vehicles
where not exists (
    select 1
    from vehicles as v2
    where v2.vehicle_id = vehicles.vehicle_id
    and vehicles.status = 'rented'
);


-- Requirement: Retrieve all available vehicles of a specific type (e.g. cars).

    -- Queries - 3
select * from vehicles
where type = 'car' and vehicles.status = 'available';

-- Requirement: Find the total number of bookings for each vehicle and display only those vehicles that have more than 2 bookings.

  -- Queries - 4
select name as vehicle_name, count(*) as total_bookings from vehicles
inner join bookings
using(vehicle_id)
group by name
having count(*) > 2;