
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------------------------------------------------------
-- Schema CAPSTONE_KGORDONBERCICH
-- ----------------------------------------------------------------------------
DROP SCHEMA IF EXISTS CAPSTONE_KGORDONBERCICH;
CREATE SCHEMA IF NOT EXISTS CAPSTONE_KGORDONBERCICH;

-- ----------------------------------------------------------------------------
-- Database CAPSTONE
-- ----------------------------------------------------------------------------

DROP DATABASE IF EXISTS CAPSTONE_KGORDONBERCICH;
CREATE DATABASE CAPSTONE_KGORDONBERCICH;
USE CAPSTONE_KGORDONBERCICH;

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.States
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.States (
  StateCode VARCHAR(2) NOT NULL,
  State VARCHAR(255) NULL,
  PRIMARY KEY (StateCode));
  
-- ----------------------------------------------------------------------------
-- Table CAPSTONE.encryptionkey
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.encryptionKey (
  idencryptionKey INT(11) NOT NULL,
  encryptionkey BINARY(32) NULL,
  PRIMARY KEY (idencryptionKey));


-- ----------------------------------------------------------------------------
-- Table CAPSTONE.Regions
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.Regions (
  RegionID INT(10) NOT NULL,
  Region VARCHAR(255) NULL,
  PRIMARY KEY (RegionID));
    

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.Titles
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.Titles (
  Titles VARCHAR(255) NOT NULL,
  PRIMARY KEY (Titles));

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.Department
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.Department (
  DepartmentID VARCHAR(255) NOT NULL,
  Department VARCHAR(255) NULL,
  PRIMARY KEY (DepartmentID));

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.W2Status
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.W2Status (
  W2StatusID INT(10) NOT NULL,
  Status VARCHAR(255) NULL,
  PRIMARY KEY (W2StatusID));

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.Exemptions
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.Exemptions (
  ExemptionID INT(10) NOT NULL,
  Exemptions VARCHAR(255) NULL,
  PRIMARY KEY (ExemptionID));
SET FOREIGN_KEY_CHECKS = 1;

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.Employees
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.Employees (
  EmployeeID INT(10) NOT NULL,
  EmployeeFirstName VARCHAR(255) NULL,
  EmployeeLastName VARCHAR(255) NULL,
  EmployeeTitle VARCHAR(255) NULL,
  EmployeeAddress VARCHAR(255) NULL,
  EmployeeCity VARCHAR(255) NULL,
  State VARCHAR(2) NULL,
  EmployeeZip VARCHAR(10) NULL,
  EmployeeHomePhone VARCHAR(15) NULL,
  EmployeeCellPhone VARCHAR(15) NULL,
  EmployeeEmail LONGTEXT NULL,
  Region INT(10) NULL,
  DepartmentID VARCHAR(255) NULL,
  StartDate VARCHAR(255) NULL,
  EndDate VARCHAR(255) NULL,
  Social VARCHAR(11) NULL,-- formatted ddd-dd-dddd
  Status INT(10) NULL,
  Exemptions INT(10) NULL,
  PayRate DECIMAL(19,4) NULL, -- hourly pay rate
  eeImage CHAR(52) NULL,
  PRIMARY KEY (EmployeeID),
  CONSTRAINT DepartmentEmployees
    FOREIGN KEY (DepartmentID)
    REFERENCES Department (DepartmentID)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT W2StatusEmployees
    FOREIGN KEY (Status)
    REFERENCES W2Status (W2StatusID)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT,
  CONSTRAINT RegionsEmployees
    FOREIGN KEY (Region)
    REFERENCES Regions (RegionID)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT TitlesEmployees
    FOREIGN KEY (EmployeeTitle)
    REFERENCES Titles (Titles)
    ON DELETE CASCADE
    ON UPDATE CASCADE,
  CONSTRAINT States
    FOREIGN KEY (State)
    REFERENCES States (StateCode)
    ON DELETE CASCADE
    ON UPDATE RESTRICT,
  CONSTRAINT ExemptionsEmployees
    FOREIGN KEY (Exemptions)
    REFERENCES Exemptions (ExemptionID)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT);

-- ----------------------------------------------------------------------------
-- Table CAPSTONE.UserIDandPassword
-- ----------------------------------------------------------------------------
CREATE TABLE IF NOT EXISTS CAPSTONE_KGORDONBERCICH.UserIDandPassword (
  PasswordID INT(10) NOT NULL,
  EmployeeID INT(10) NULL,
  UserID VARCHAR(255) NULL,
  PasswordWord BINARY(128) NULL,
  PRIMARY KEY (PasswordID),
  CONSTRAINT EmployeesUserIDandPassword
    FOREIGN KEY (EmployeeID)
    REFERENCES Employees (EmployeeID)
    ON DELETE RESTRICT
    ON UPDATE RESTRICT);
    
    



-- ----------------------------------------------------------------------------
-- Data Insert
-- ----------------------------------------------------------------------------
INSERT INTO States VALUES ('AL', 'Alabama');
INSERT INTO States VALUES ('AK', 'Alaska');
INSERT INTO States VALUES ('AS','American Somoa');
INSERT INTO States VALUES ('AZ', 'Arizona');
INSERT INTO States VALUES ('AR', 'Arkansas');
INSERT INTO States VALUES ('CA', 'California');
INSERT INTO States VALUES ('CO', 'Colorado');
INSERT INTO States VALUES ('CT','Connecticut');
INSERT INTO States VALUES ('DE', 'Deleware');
INSERT INTO States VALUES ('DC', 'Distric of Columbia');
INSERT INTO States VALUES ('FL', 'Florida');
INSERT INTO States VALUES ('GA', 'Georgia');
INSERT INTO States VALUES ('GU', 'Guam');
INSERT INTO States VALUES ('HI', 'Hawaii');
INSERT INTO States VALUES ('ID', 'Idaho');
INSERT INTO States VALUES ('IL', 'Illinois');
INSERT INTO States VALUES ('IN', 'Indiana');
INSERT INTO States VALUES ('IA', 'Iowa');
INSERT INTO States VALUES ('KS', 'Kansas');
INSERT INTO States VALUES ('KY', 'Kentucky');
INSERT INTO States VALUES ('LA', 'Louisiana');
INSERT INTO States VALUES ('ME', 'Maine');
INSERT INTO States VALUES ('MD', 'Maryland');
INSERT INTO States VALUES ('MA', 'Massachusetts');
INSERT INTO States VALUES ('MI', 'Michigan');
INSERT INTO States VALUES ('MN', 'Minnesota');
INSERT INTO States VALUES ('MS', 'Mississippi');
INSERT INTO States VALUES ('MO', 'Missouri');
INSERT INTO States VALUES ('MT', 'Montana');
INSERT INTO States VALUES ('NE', 'Nebraska');
INSERT INTO States VALUES ('NV', 'Nevada');
INSERT INTO States VALUES ('NH', 'New Hampshire');
INSERT INTO States VALUES ('NJ', 'New Jersey');
INSERT INTO States VALUES ('NM', 'New Mexico');
INSERT INTO States VALUES ('NY', 'New York');
INSERT INTO States VALUES ('NC', 'North Carolina');
INSERT INTO States VALUES ('ND', 'North Dakota');
INSERT INTO States VALUES ('MP', 'Northen Mariana Island');
INSERT INTO States VALUES ('OH', 'Ohio');
INSERT INTO States VALUES ('OK', 'Oklahoma');
INSERT INTO States VALUES ('OR', 'Oregon');
INSERT INTO States VALUES ('PA', 'Pennsylvania');
INSERT INTO States VALUES ('PR', 'Puerto Rico');
INSERT INTO States VALUES ('RI', 'Rhode Island');
INSERT INTO States VALUES ('SC', 'South Carolina');
INSERT INTO States VALUES ('SD', 'South Dakota');
INSERT INTO States VALUES ('TN', 'Tennessee');
INSERT INTO States VALUES ('TX', 'Texas');
INSERT INTO States VALUES ('VI', 'US Virgin Islands');
INSERT INTO States VALUES ('UT', 'Utah');
INSERT INTO States VALUES ('VT', 'Vermont');
INSERT INTO States VALUES ('VA', 'Virginia');
INSERT INTO States VALUES ('WA', 'Washington');
INSERT INTO States VALUES ('WV', 'West Virginia');
INSERT INTO States VALUES ('WI', 'Wisconsin');
INSERT INTO States VALUES ('WY', 'Wyoming');

INSERT INTO encryptionKey VALUES(1, 'encryption');

INSERT INTO Regions VALUES(1, 'Corporate Headquarters');
INSERT INTO Regions VALUES(2, 'Northeast Region');
INSERT INTO Regions VALUES(3, 'Southeast Region');
INSERT INTO Regions VALUES(4, 'Central Region');
INSERT INTO Regions VALUES(5, 'Northwest Region');
INSERT INTO Regions VALUES(6, 'Southwest Region');

INSERT INTO Titles VALUES ('Accountant I');
INSERT INTO Titles VALUES ('Accountant II');
INSERT INTO Titles VALUES ('Accountant III');
INSERT INTO Titles VALUES ('Administrative Assistant');
INSERT INTO Titles VALUES ('Buyer');
INSERT INTO Titles VALUES ('Chairman');
INSERT INTO Titles VALUES ('Chief Executive Officer (CEO)');
INSERT INTO Titles VALUES ('Chief Financial Officer (CFO)');
INSERT INTO Titles VALUES ('Chief Human Resources Officer');
INSERT INTO Titles VALUES ('Chief Informational Officer (CIO)');
INSERT INTO Titles VALUES ('Chief Technology Officer');
INSERT INTO Titles VALUES ('Comptroller');
INSERT INTO Titles VALUES ('Director of Finance');
INSERT INTO Titles VALUES ('Director of Human Resources');
INSERT INTO Titles VALUES ('Director of Marketing');
INSERT INTO Titles VALUES ('Director of Operations');
INSERT INTO Titles VALUES ('Director of PR');
INSERT INTO Titles VALUES ('Director of Purchasing');
INSERT INTO Titles VALUES ('Director of Sales Central Region');
INSERT INTO Titles VALUES ('Director of Sales Northeast Region');
INSERT INTO Titles VALUES ('Director of Sales Northwest Region');
INSERT INTO Titles VALUES ('Director of Sales Southeast Region');
INSERT INTO Titles VALUES ('Director of Sales Southwest Region');
INSERT INTO Titles VALUES ('Executive Assistant');
INSERT INTO Titles VALUES ('IT Tech');
INSERT INTO Titles VALUES ('Manager');
INSERT INTO Titles VALUES ('President');
INSERT INTO Titles VALUES ('Sales Administrative Assistant');
INSERT INTO Titles VALUES ('Sales Representative');
INSERT INTO Titles VALUES ('Vice President');

INSERT INTO Department VALUES('01-D&R','Design & Research');
INSERT INTO Department VALUES('03-Fnc', 'Finance');
INSERT INTO Department VALUES('05-HmnRsc','Human Resources');
INSERT INTO Department VALUES('10-IT','Information Technology');
INSERT INTO Department VALUES('02-Mnfctng','Manufacturing');
INSERT INTO Department VALUES('04-MktPlng','Marketing/Planning');
INSERT INTO Department VALUES('08-Op','Operations');
INSERT INTO Department VALUES('07-PR','Public Relations / Community Affairs');
INSERT INTO Department VALUES('09-Purc','Purchasing');
INSERT INTO Department VALUES('06-Sls','Sales');

INSERT INTO W2Status VALUES(2, 'Married');
INSERT INTO W2Status VALUES(3, 'Married filing at the higher Single rate.');
INSERT INTO W2Status VALUES(1, 'Single');

INSERT INTO Exemptions VALUES(10, '0');
INSERT INTO Exemptions VALUES(1, '1 child');
INSERT INTO Exemptions VALUES(2, '2 child(ren)');
INSERT INTO Exemptions VALUES(3, '3 child(ren)');
INSERT INTO Exemptions VALUES(4, '4 child(ren)');
INSERT INTO Exemptions VALUES(5, '5 child(ren)');
INSERT INTO Exemptions VALUES(6, '6 child(ren)');
INSERT INTO Exemptions VALUES(7, '7 child(ren)');
INSERT INTO Exemptions VALUES(8, '8 child(ren)');
INSERT INTO Exemptions VALUES(9, '9 child(ren)');

INSERT INTO Employees VALUES(5, 'James', 'Bassett', 'Administrative Assistant', '9845 43rd Ave., Apt. 23-102', 'New York', 'NY', '10001-5656', '(212) 451-1421', '(212) 652-3121', 'jamesbassett@givetotheneedy.com', 2, '05-HmnRsc', '08/23/2014', '', '965-41-3245', 1, 1, 36.5, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(6, 'Charlotte', 'Harper', 'Administrative Assistant', '2136 88th Ave., Apt. 34-A', 'Coco Beach', 'FL', '32501-2301', '(305) 421-6321', '(305) 894-6123', 'charletteharper@givetotheneedy.com', 3, '07-PR', '9/05/2013', '', '956-31-7456', 2, 10, 27.56, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(7, 'William', 'Jones', 'Accountant I', '10236 S. Houston St.Apt. 34-A', 'Coco Beach', 'FL', '32501-2301', '(305) 421-6321', '(305) 894-6123', 'charletteharper@givetotheneedy.com', 3, '07-PR', '9/05/2013', '', '956-31-7456', 2, 10, 27.56, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(8, 'Elijah', 'Goldman', 'Accountant II', '21369 Friendly St.', 'Portland', 'OR', '97201-0000', '(503) 212-4569', '(503) 214-7986', 'elijahgoldman@givetotheneedy.com', 5, '03-Fnc', '04/25/2013', '', '956-32-1459', 2, 2, 43.12, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(9, 'Madison', 'Findley', 'Accountant III', '9874 Green Trail Cir.', 'Dallas', 'TX', '75124-5632', '(214) 895-2314', '(214) 895-6412', 'madisonfindley@givetotheneedy.com', 4, '03-Fnc', '03/18/2014', '', '125-61-4895', 1, 1, 47.4656, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(10, 'James', 'Killington', 'Accountant I', '2698 Prescott Ave.', 'Dallas', 'TX', '75001-2356', '(214) 956-3214', '(972) 932-5612', 'jameskilllington@givetotheneedy.com', 4, '03-Fnc', '10/21/2015', '', '562-32-6912', 1, 10, 37.4752, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(11, 'Aubrey', 'Yayah', 'Accountant II', '9632 Sunbelt Cir.', 'Pheonix', 'AZ', '85001-2360', '(480) 562-3014', '(480) 561-6513', 'audreyyayah@givetotheneedy.com', 6, '03-Fnc', '07/26/2015', '', '659-87-4123', 1, 10, 44.8, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(12, 'David', 'Simms', 'Accountant III', '1423 Coco Beach Blvd.', 'Coco Beach', 'FL', '33124-0000', '(239) 654-7891', '(239) 652-1332', 'davidsimms@givetotheneedy.com', 3, '03-Fnc', '09/18/2015', '', '562-96-5321', 2, 10, 47.208, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(14, 'Sophia', 'Rodriguez', 'Manager', '3269 Snow White Cir.', 'Dallas', 'TX', '75124-', '(214) 678-9652', '(214) 521-3032', 'sophiarodriguez@givetotheneedy.com', 4, '06-Sls', '03/01/2012', '', '569-35-6521', 1, 1, 38.5, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(15, 'Daniel', 'Fitzpatrick', 'Manager', '3695 Cloudy Lane', 'Portland', 'OR', '97201-0000', '(500) 365-1234', '(500) 555-3598', 'danielfitzpatrick@givetotheneedy.com', 5, '06-Sls', '10/5/2013', '', '569-87-4663', 2, 3, 57.7, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(16, 'Victoria', 'Goldberg', 'Manager', '3457 Beach Front Ave.', 'Coco Beach', 'FL', '32501-3215', '(239) 659-8945', '(239) 659-1326', 'victoriagoldberg@givetotheneedy.com', 3, '06-Sls', '06/21/2015', '', '231-56-3269', 3, 3, 55.25, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(17, 'Madison', 'Gudmundson', 'Comptroller', '2364 Park Ave.', 'New York', 'NY', '10001-0000', '(212) 653-2691', '(212) 456-9832', 'madiosngudmundson@givetotheneedy.com', 1, '03-Fnc', '12/01/2015', '', '659-32-4568', 2, 2, 60.704, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(18, 'Jack', 'Knightly', 'Sales Representative', '5693 Silly Cir.', 'Livinstong', 'NJ', '07039-', '(201) 569-8412', '(201) 569-2314', 'jackknightly@givetotheneedy.com', 2, '06-Sls', '04/05/2013', '', '569-85-1326', 2, 1, 56.89, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(19, 'Ella', 'Jenkins', 'Sales Representative', '2356 Sunset Blvd.', 'Coco Beach', 'FL', '32501-0000', '(239) 561-2345', '(239) 651-2348', 'ellajenkins@givetotheneedy.com', 3, '06-Sls', '12/9/2012', '', '659-87-3265', 3, 2, 62.0, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(20, 'Aaron', 'Nash', 'Sales Representative', '2356 Rt. Rd.', 'Crandal', 'TX', '75142-0000', '(972) 546-8979', '(214) 564-9879', 'aaronnash@givetotheneedy.com', 4, '06-Sls', '08/18/2012', '', '659-78-4561', 3, 10, 54.25, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(21, 'Barry', 'Lischous', 'Sales Representative', '5698 Happy Trail', 'Pheonix', 'AZ', '85001-0000', '(480) 580-1078', '(480) 512-6323', 'barrylicous@givetotheneedy.com', 6, '06-Sls', '03/27/2016', '', '569-87-5613', 1, 1, 49.89, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(22, 'Jason', 'Ryan', 'Sales Representative', '5612 Dark Horse Cir.', 'Portland', 'OR', '97201-', '(503) 213-4567', '(503) 651-7895', 'jasonryan@givetotheneedy.com', 5, '06-Sls', '07/21/2012', '', '123-45-6789', 2, 10, 56.89, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(23, 'Tracey', 'Patrick', 'IT Tech', '5646 Cleveland Ln.', 'Cheyenne', 'WY', '82001-', '(307) 569-8789', '(307) 567-8789', 'traceypatrick@givetotheneedy.com', 1, '10-IT', '06/04/2014', '', '123-56-7894', 3, 3, 89.99, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(24, 'Charlotte', 'Scott', 'Director of Finance', '2121 Park Ave.', 'New York', 'NY', '10001-', '(212) 123-4565', '(212) 231-6545', 'charlottescott@givetotheneedy.com', 1, '03-Fnc', '05/07/2014', '', '123-45-6888', 1, 10, 58.0, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(25, 'Lance', 'Armstrong', 'Director of Marketing', '2369 Park Ave.', 'New York', 'NY', '10001-', '(212) 123-4561', '(212) 456-1237', 'lancearmstrong@givetotheneedy.com', 1, '04-MktPlng', '09/06/2012', '', '123-98-4567', 1, 10, 52.0, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(26, 'Heather', 'Wright', 'Director of Human Resources', '4871 Park Ave.', 'New York', 'NY', '10001-', '(212) 568-9414', '(212) 568-7894', 'heatherwright@givetotheneedy.com', 1, '05-HmnRsc', '08/19/2015', '', '123-89-4567', 2, 1, 39.0, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(27, 'Simmon', 'Coell', 'Director of Operations', '9812 S Houston Rd.', 'New York', 'NY', '10001-', '(212) 454-3265', '(212) 454-3698', 'simmoncoell@givetotheneedy.com', 1, '08-Op', '07/06/2013', '', '123-75-4689', 2, 3, 41.85, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(28, 'Jason', 'Bourne', 'Director of Sales Central Region', '89143 Montecito Blvd.', 'Dallas', 'TX', '75142-', '(214) 564-7891', '(214) 565-7892', 'jasonbourne@givetotheneedy.com', 4, '06-Sls', '01/10/2011', '', '456-12-7891', 2, 10, 42.0, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(29, 'Dana', 'Goldberb', 'Director of Sales Southeast Region', '6598 Sunrise Place', 'Coco Beach', 'FL', '32501-', '(239) 123-5698', '(239) 231-5689', 'danagoldberg@givetotheneedy.com', 3, '06-Sls', '11/03/2012', '', '123-89-4567', 2, 10, 48.13, 'src/resources/MissPiggy.jpg');
INSERT INTO Employees VALUES(30, 'Jerry', 'Seinfeld', 'Director of Sales Northeast Region', '52637 Park Ave.', 'New York', 'NY', '10001-', '(212) 658-9561', '(212) 654-7891', 'jerryseinfeld@givetotheneedy.com', 2, '06-Sls', '07/23/2014', '', '145-23-7891', 1, 3, 54.65, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(31, 'Nathan', 'Gould', 'Director of Sales Northwest Region', '2314 Cloudy Street', 'New York', 'NY', '10001-', '(212) 234-5678', '(212) 234-6541', 'nathangould@givetotheneedy.com', 5, '06-Sls', '03/14/2015', '', '123-89-4567', 1, 10, 53.25, 'src/resources/Kermit.jpg');
INSERT INTO Employees VALUES(32, 'Henry', 'Cash', 'Director of Sales Southwest Region', '5645 Happy Trails Ln', 'Pheonix', 'AZ', '85001-', '(480) 552-1346', '(480) 552-3164', 'henrycash@givetotheneedy.com', 6, '06-Sls', '03/26/2013', '', '122-34-6598', 1, 10, 56.23, 'src/resources/Kermit.jpg');

INSERT INTO UserIDandPassword VALUES(1, 5, 'jbassett', 'password');
INSERT INTO UserIDandPassword VALUES(2, 6, 'charper', 'password');
INSERT INTO UserIDandPassword VALUES(3, 7, 'wjones', 'password');
INSERT INTO UserIDandPassword VALUES(4, 8, 'egoldman', 'password');
INSERT INTO UserIDandPassword VALUES(5, 9, 'mfindley', 'password');
INSERT INTO UserIDandPassword VALUES(6, 10, 'jkillington', 'password');
INSERT INTO UserIDandPassword VALUES(7, 11, 'ayayah', 'password');
INSERT INTO UserIDandPassword VALUES(8, 12, 'dsimms', 'password');
INSERT INTO UserIDandPassword VALUES(9, 14, 'srodriguez', 'password');
INSERT INTO UserIDandPassword VALUES(10, 15, 'dfitzpatrick', 'password');
INSERT INTO UserIDandPassword VALUES(11, 16, 'vgoldberg', 'password');
INSERT INTO UserIDandPassword VALUES(12, 17, 'mgudmundson', 'password');
INSERT INTO UserIDandPassword VALUES(13, 18, 'jknightly', 'password');
INSERT INTO UserIDandPassword VALUES(14, 19, 'ejenkins', 'password');
INSERT INTO UserIDandPassword VALUES(15, 20, 'anash', 'password');
INSERT INTO UserIDandPassword VALUES(16, 21, 'blishous', 'password');
INSERT INTO UserIDandPassword VALUES(17, 22, 'jryan', 'password');
INSERT INTO UserIDandPassword VALUES(18, 23, 'tpatrick', 'password');
INSERT INTO UserIDandPassword VALUES(19, 24, 'cscott', 'password');
INSERT INTO UserIDandPassword VALUES(20, 25, 'larmstrong', 'password');
INSERT INTO UserIDandPassword VALUES(21, 26, 'hwright', 'password');
INSERT INTO UserIDandPassword VALUES(22, 27, 'scoell', 'password');
INSERT INTO UserIDandPassword VALUES(23, 28, 'jbourne', 'password');
INSERT INTO UserIDandPassword VALUES(24, 29, 'dgoldberg', 'password');
INSERT INTO UserIDandPassword VALUES(25, 30, 'jseinfeld','password');
INSERT INTO UserIDandPassword VALUES(26, 31, 'ngould', 'password');
INSERT INTO UserIDandPassword VALUES(27, 32, 'hcash', 'password');

-- ----------------------------------------------------------------------------
-- Encryption use aes encrption
-- ----------------------------------------------------------------------------
UPDATE useridandpassword
	SET PasswordWord = aes_encrypt('password', 'encryption')
	WHERE PasswordID > 0;
