CREATE TABLE User (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL CHECK (CHAR_LENGTH(password) >= 16),
    phone_notification BOOLEAN DEFAULT 0,
    phone_number VARCHAR(10)
);

CREATE TABLE Location (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    city VARCHAR(255) NOT NULL,
    country VARCHAR(255) NOT NULL
);

CREATE TABLE AirlineCompany (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    company_name VARCHAR(255) NOT NULL
);

CREATE TABLE Airport (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    airport_name VARCHAR(255) NOT NULL,
    served_cities JSON NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Location(UniqueID)
);

CREATE TABLE Flight (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    booking_open_status BOOLEAN NOT NULL,
    flight_status BOOLEAN NOT NULL,
    departure_airport INT NOT NULL,
    arrival_airport INT NOT NULL,
    departure_date DATETIME NOT NULL,
    arrival_date DATETIME NOT NULL,
    airline_company_id INT NOT NULL,
    FOREIGN KEY (departure_airport) REFERENCES Airport(UniqueID),
    FOREIGN KEY (arrival_airport) REFERENCES Airport(UniqueID),
    FOREIGN KEY (airline_company_id) REFERENCES AirlineCompany(UniqueID)
);

CREATE TABLE Stopover (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    arrival_date DATETIME NOT NULL,
    departure_date DATETIME NOT NULL,
    location_id INT NOT NULL,
    FOREIGN KEY (location_id) REFERENCES Location(UniqueID)
);

CREATE TABLE Flight_Stopover (
    flight_id INT,
    stopover_id INT,
    PRIMARY KEY (flight_id, stopover_id),
    FOREIGN KEY (flight_id) REFERENCES Flight(UniqueID),
    FOREIGN KEY (stopover_id) REFERENCES Stopover(UniqueID)
);

CREATE TABLE Passenger (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    age INT NOT NULL CHECK (age >= 0)
);

CREATE TABLE Booking (
    UniqueID INT PRIMARY KEY AUTO_INCREMENT,
    booking_status BOOLEAN NOT NULL,
    user_id INT NOT NULL,
    flight_id INT NOT NULL,
    FOREIGN KEY (user_id) REFERENCES User(UniqueID),
    FOREIGN KEY (flight_id) REFERENCES Flight(UniqueID)
);

CREATE TABLE Booking_Passenger (
    booking_id INT,
    passenger_id INT,
    PRIMARY KEY (booking_id, passenger_id),
    FOREIGN KEY (booking_id) REFERENCES Booking(UniqueID),
    FOREIGN KEY (passenger_id) REFERENCES Passenger(UniqueID)
);