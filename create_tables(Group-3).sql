-- Terminate all active connections to the database
USE master;
GO
IF EXISTS (SELECT name FROM sys.databases WHERE name = 'RecruitmentSystem')
BEGIN
    ALTER DATABASE RecruitmentSystem SET SINGLE_USER WITH ROLLBACK IMMEDIATE;
    DROP DATABASE RecruitmentSystem;
END
GO

-- Create Database
CREATE DATABASE RecruitmentSystem;
GO

-- Use the created database
USE RecruitmentSystem;
GO

-- Drop existing tables to allow script re-execution
DROP TABLE IF EXISTS Communication;
DROP TABLE IF EXISTS HiringDecision;
DROP TABLE IF EXISTS InterviewFeedback;
DROP TABLE IF EXISTS InterviewSchedule;
DROP TABLE IF EXISTS InterviewPanelAssignment;
DROP TABLE IF EXISTS Interview;
DROP TABLE IF EXISTS Referral;
DROP TABLE IF EXISTS Applications;
DROP TABLE IF EXISTS Applicant;
DROP TABLE IF EXISTS Job;
DROP TABLE IF EXISTS Department;
DROP TABLE IF EXISTS RecruiterJob;
DROP TABLE IF EXISTS Recruiter;
DROP TABLE IF EXISTS Panelist;

-- Create tables with primary keys and identity columns
CREATE TABLE Recruiter (
    RecruiterID INT PRIMARY KEY IDENTITY(1,1),
    Email_Address VARCHAR(255) NOT NULL,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    PhoneNumber VARCHAR(15) NOT NULL,
    Status_type VARCHAR(50)
);

CREATE TABLE Department (
    DepartmentID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentName VARCHAR(100) NOT NULL,
    Location_name VARCHAR(100) NOT NULL,
    Email_Address VARCHAR(255) NOT NULL
);

CREATE TABLE Job (
    JobID INT PRIMARY KEY IDENTITY(1,1),
    DepartmentID INT,
    Title VARCHAR(100) NOT NULL,
    Job_Description TEXT,
    SalaryMin INT,
    SalaryMax INT,
    Deadline DATE,
    Status_type VARCHAR(50) NOT NULL,
    FOREIGN KEY (DepartmentID) REFERENCES Department(DepartmentID),
    CONSTRAINT chk_salary CHECK (SalaryMax >= SalaryMin) -- Table-level constraint
);

CREATE TABLE Applicant (
    ApplicantID INT PRIMARY KEY IDENTITY(1,1),
    Email VARCHAR(255) NOT NULL UNIQUE,
    FirstName VARCHAR(100) NOT NULL,
    LastName VARCHAR(100) NOT NULL,
    Phone VARCHAR(15) CHECK (Phone IS NULL OR Phone LIKE '[0-9]%'),
    App_Address TEXT,
    ResumeLink VARCHAR(255),
    RegistrationDate DATE NOT NULL
);

CREATE TABLE Applications (
    ApplicationID INT PRIMARY KEY IDENTITY(1,1),
    JobID INT,
    ApplicantID INT,
    SubmissionDate DATE NOT NULL,
    Source VARCHAR(50),
    Status_type VARCHAR(50),
    FOREIGN KEY (JobID) REFERENCES Job(JobID),
    FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);

CREATE TABLE Referral (
    ReferralID INT PRIMARY KEY IDENTITY(1,1),
    ApplicantID INT,
    ReferralEmail VARCHAR(255),
    ReferralName VARCHAR(100),
    ReferralPhone VARCHAR(15),
    ReferralDate DATE,
    Status_type VARCHAR(50),
    FOREIGN KEY (ApplicantID) REFERENCES Applicant(ApplicantID)
);

CREATE TABLE Interview (
    InterviewID INT PRIMARY KEY IDENTITY(1,1),
    ApplicationID INT,
    Interview_Type VARCHAR(50),
    Status_type VARCHAR(50),
    FOREIGN KEY (ApplicationID) REFERENCES Applications(ApplicationID)
);

CREATE TABLE InterviewSchedule (
    ScheduleID INT PRIMARY KEY IDENTITY(1,1),
    InterviewID INT,
    StartTime DATETIME NOT NULL,
    EndTime DATETIME NOT NULL,
    Interview_Location VARCHAR(100),
    MeetingLink VARCHAR(255),
    FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID)
);

CREATE TABLE HiringDecision (
    DecisionID INT PRIMARY KEY IDENTITY(1,1),
    InterviewID INT,
    Hiring_Status VARCHAR(50),
    OfferAmount FLOAT CHECK (OfferAmount >= 0),
    DecisionDate DATE,
    FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID)
);

CREATE TABLE InterviewFeedback (
    FeedbackID INT PRIMARY KEY IDENTITY(1,1),
    InterviewID INT,
    Comments TEXT,
    Rating INT CHECK (Rating BETWEEN 1 AND 5), -- Example constraint
    SubmissionTime DATETIME NOT NULL,
    FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID)
);

CREATE TABLE RecruiterJob (
    AssignmentID INT PRIMARY KEY IDENTITY(1,1),
    RecruiterID INT,
    JobID INT,
    AssignmentDate DATE,
    AssignmentStatus VARCHAR(50),
    FOREIGN KEY (RecruiterID) REFERENCES Recruiter(RecruiterID),
    FOREIGN KEY (JobID) REFERENCES Job(JobID)
);

CREATE TABLE Panelist (
   PanelistID INT PRIMARY KEY IDENTITY(1,1),
   Email_Address VARCHAR(255) NOT NULL,
   FirstName VARCHAR(100) NOT NULL,
   LastName VARCHAR(100) NOT NULL,
   Designation VARCHAR(50),
   Status_type VARCHAR(50)
);

CREATE TABLE InterviewPanelAssignment (
   AssignmentID INT PRIMARY KEY IDENTITY(1,1),
   InterviewID INT,
   PanelistID INT,
   Assignment_Role VARCHAR(50),
   FOREIGN KEY (InterviewID) REFERENCES Interview(InterviewID),
   FOREIGN KEY (PanelistID) REFERENCES Panelist(PanelistID)
);
GO

USE RecruitmentSystem;
SELECT TABLE_NAME FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_TYPE = 'BASE TABLE';
