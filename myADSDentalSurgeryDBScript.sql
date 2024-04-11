CREATE TABLE Dentists (
    DentistID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ContactPhoneNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    Specialization VARCHAR(100)
);

-- Create OfficeManagers table
CREATE TABLE OfficeManagers (
    ManagerID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ContactPhoneNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE
);

-- Create Patients table
CREATE TABLE Patients (
    PatientID INT PRIMARY KEY,
    FirstName VARCHAR(50),
    LastName VARCHAR(50),
    ContactPhoneNumber VARCHAR(15),
    Email VARCHAR(100) UNIQUE,
    MailingAddress VARCHAR(255),
    DateOfBirth DATE
);

-- Create Appointments table
CREATE TABLE Appointments (
    AppointmentID INT PRIMARY KEY,
    PatientID INT,
    DentistID INT,
    AppointmentDateTime DATETIME,
    Status VARCHAR(20), -- Pending, Confirmed, Cancelled
    FOREIGN KEY (PatientID) REFERENCES Patients(PatientID),
    FOREIGN KEY (DentistID) REFERENCES Dentists(DentistID)
);

-- Create Surgeries table
CREATE TABLE Surgeries (
    SurgeryID INT PRIMARY KEY,
    Name VARCHAR(100),
    LocationAddress VARCHAR(255),
    TelephoneNumber VARCHAR(15)
);

CREATE TABLE DentistAppointments (
    DentistID INT,
    AppointmentID INT,
    FOREIGN KEY (DentistID) REFERENCES Dentists(DentistID),
    FOREIGN KEY (AppointmentID) REFERENCES Appointments(AppointmentID)
);


INSERT INTO Dentists (DentistID, FirstName, LastName, ContactPhoneNumber, Email, Specialization) VALUES
(1, 'John', 'Doe', '123456789', 'john.doe@example.com', 'General Dentistry'),
(2, 'Jane', 'Smith', '987654321', 'jane.smith@example.com', 'Orthodontics');

INSERT INTO OfficeManagers (ManagerID, FirstName, LastName, ContactPhoneNumber, Email) VALUES
(1, 'Emily', 'Johnson', '5551234567', 'emily.johnson@example.com');

INSERT INTO Patients (PatientID, FirstName, LastName, ContactPhoneNumber, Email, MailingAddress, DateOfBirth) VALUES
(1, 'Michael', 'Davis', '5559876543', 'michael.davis@example.com', '123 Main St, City, Country', '1990-05-15'),
(2, 'Sarah', 'Brown', '5558765432', 'sarah.brown@example.com', '456 Elm St, City, Country', '1985-08-20');

INSERT INTO Surgeries (SurgeryID, Name, LocationAddress, TelephoneNumber) VALUES
(1, 'City Dental Clinic', '789 Oak St, City, Country', '5557890123'),
(2, 'Green Valley Dental Care', '456 Maple St, City, Country', '5554567890');


SELECT * FROM Dentists ORDER BY LastName ASC;

SELECT A.AppointmentID, A.AppointmentDateTime, P.FirstName AS PatientFirstName, P.LastName AS PatientLastName
FROM Appointments A
JOIN Patients P ON A.PatientID = P.PatientID
WHERE A.DentistID = {dentist_id};


SELECT A.AppointmentID, A.AppointmentDateTime, D.FirstName AS DentistFirstName, D.LastName AS DentistLastName
FROM Appointments A
JOIN Dentists D ON A.DentistID = D.DentistID
JOIN Surgeries S ON D.SurgeryID = S.SurgeryID
WHERE S.Name = '{surgery_location}';

SELECT A.AppointmentID, A.AppointmentDateTime, D.FirstName AS DentistFirstName, D.LastName AS DentistLastName
FROM Appointments A
JOIN Dentists D ON A.DentistID = D.DentistID
WHERE A.PatientID = {patient_id} AND DATE(A.AppointmentDateTime) = '2024-04-10';