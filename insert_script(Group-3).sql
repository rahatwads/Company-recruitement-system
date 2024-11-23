-- Use the correct database
USE RecruitmentSystem;
GO

-- Insert data into Recruiter
INSERT INTO Recruiter (Email_Address, FirstName, LastName, PhoneNumber, Status_type) VALUES
('bivraajkohli@dell.com', 'Bivraaj', 'Kohli', '12345671', 'Inactive'),
('shivani2@dell.com', 'Shivani', 'Sharma', '12345672', 'Active'),
('parnesh3@dell.com', 'Parnesh', 'Rao', '12345673', 'Inactive'),
('bhargav4@dell.com', 'Bhargav', 'Gandhi', '12345674', 'Active'),
('satwika5@dell.com', 'Satwika', 'Readdy', '12345675', 'Inactive'),
('ayushi6@dell.com', 'Ayushi', 'Ghia', '12345676', 'Active'),
('disha7@dell.com', 'Disha', 'Shivkumar', '12345677', 'Inactive'),
('tharunshrey8@dell.com', 'Tharunshrey', 'Gurrampati', '12345677', 'Inactive'),
('aryan9@dell.com', 'Aryan', 'Kumar', '12345679', 'Inactive'),
('rahul10@dell.com', 'Rahul', 'Dravid', '123456710', 'Active');

-- Insert data into Department
INSERT INTO Department (DepartmentName, Location_name, Email_Address) VALUES
('Human Resources', 'New York', 'hr@dell.com'),
('Marketing', 'Los Angeles', 'marketing@dell.com'),
('Finance', 'Chicago', 'finance@dell.com'),
('IT', 'San Francisco', 'it@dell.com'),
('Sales', 'Dallas', 'sales@dell.com'),
('Customer Service', 'Miami', 'customerservice@dell.com'),
('Research and Development', 'Boston', 'research@dell.com'),
('Legal', 'Washington D.C.', 'legal@dell.com'),
('Operations', 'Seattle', 'operations@dell.com'),
('Product Management', 'Austin', 'productmanagement@dell.com');

-- Insert data into Job
INSERT INTO Job (DepartmentID, Title, Job_Description, SalaryMin, SalaryMax, Deadline, Status_type) VALUES
(1, 'HR Manager', 'Oversee HR operations', 70000, 100000, '2024-12-31', 'Open'),
(2, 'Marketing Specialist', 'Develop marketing strategies', 55000, 80000, '2024-11-30', 'Open'),
(3, 'Financial Analyst', 'Perform financial analysis', 60000, 90000, '2024-12-15', 'Open'),
(4, 'Software Developer', 'Develop and maintain software', 75000, 120000, '2024-11-15', 'Open'),
(5, 'Sales Representative', 'Generate leads and close sales', 50000, 85000, '2024-12-01', 'Open'),
(6, 'Customer Service Rep', 'Handle customer inquiries', 40000, 60000, '2024-11-20', 'Open'),
(7, 'Research Scientist', 'Conduct scientific research', 80000, 130000, '2025-01-15', 'Open'),
(8, 'Legal Counsel', 'Provide legal advice', 90000, 150000, '2024-12-10', 'Open'),
(9, 'Operations Manager', 'Manage daily operations', 65000, 110000, '2024-11-25', 'Open'),
(10, 'Product Manager', 'Oversee product development', 75000, 125000, '2024-12-20', 'Open');

-- Insert data into Applicant
INSERT INTO Applicant (Email, FirstName, LastName, Phone, App_Address, ResumeLink, RegistrationDate) VALUES
('john.doe@email.com', 'John', 'Doe', '555-0101', '123 Main St, Anytown, USA', 'https://resume.com/johndoe', '2024-10-15'),
('jane.smith@email.com', 'Jane', 'Smith', '555-0102', '456 Oak Ave, Somewhere, USA', 'https://resume.com/janesmith', '2024-10-16'),
('mike.johnson@email.com', 'Mike', 'Johnson', '555-0103', '789 Pine Rd, Elsewhere, USA', 'https://resume.com/mikejohnson', '2024-10-17'),
('emily.brown@email.com', 'Emily', 'Brown', '555-0104', '321 Elm St, Nowhere, USA', 'https://resume.com/emilybrown', '2024-10-18'),
('david.wilson@email.com', 'David', 'Wilson', '555-0105', '654 Maple Dr, Everywhere, USA', 'https://resume.com/davidwilson', '2024-10-19'),
('sarah.taylor@email.com', 'Sarah', 'Taylor', '555-0106', '987 Cedar Ln, Someplace, USA', 'https://resume.com/sarahtaylor', '2024-10-20'),
('robert.anderson@email.com', 'Robert', 'Anderson', '555-0107', '147 Birch Blvd, Anyville, USA', 'https://resume.com/robertanderson', '2024-10-21'),
('lisa.martinez@email.com', 'Lisa', 'Martinez', '555-0108', '258 Spruce St, Otherville, USA', 'https://resume.com/lisamartinez', '2024-10-22'),
('william.garcia@email.com', 'William', 'Garcia', '555-0109', '369 Fir Ave, Thattown, USA', 'https://resume.com/williamgarcia', '2024-10-23'),
('jennifer.lopez@email.com', 'Jennifer', 'Lopez', '555-0110', '741 Redwood Rd, Thistown, USA', 'https://resume.com/jenniferlopez', '2024-10-24');

-- Insert data into Applications
INSERT INTO Applications (JobID, ApplicantID, SubmissionDate, Source, Status_type) VALUES
(3, 10, '2024-11-07', 'Online', 'Submitted'),
(7, 1, '2024-11-07', 'Online', 'Submitted'),
(10, 9, '2024-11-07', 'Online', 'Submitted'),
(9, 9, '2024-11-07', 'Online', 'Submitted'),
(10, 8, '2024-11-07', 'Online', 'Submitted'),
(3, 9, '2024-11-07', 'Online', 'Submitted'),
(7, 8, '2024-11-07', 'Online', 'Submitted'),
(3, 1, '2024-11-07', 'Online', 'Submitted'),
(9, 4, '2024-11-07', 'Online', 'Submitted'),
(5, 7, '2024-11-07', 'Online', 'Submitted');

-- Insert data into Referral
INSERT INTO Referral (ApplicantID, ReferralEmail, ReferralName, ReferralPhone, ReferralDate, Status_type) VALUES
(1, 'mark.wilson@dell.com', 'Mark Wilson', '555-1001', '2024-10-20', 'Pending'),
(2, 'susan.brown@company.com', 'Susan Brown', '555-1002', '2024-10-21', 'Approved'),
(3, 'peter.jones@company.com', 'Peter Jones', '555-1003', '2024-10-22', 'Pending'),
(4, 'laura.davis@company.com', 'Laura Davis', '555-1004', '2024-10-23', 'Rejected'),
(5, 'chris.miller@company.com', 'Chris Miller', '555-1005', '2024-10-24', 'Approved'),
(6, 'anna.white@company.com', 'Anna White', '555-1006', '2024-10-25', 'Pending'),
(7, 'tom.harris@company.com', 'Tom Harris', '555-1007', '2024-10-26', 'Approved'),
(8, 'emma.clark@company.com', 'Emma Clark', '555-1008', '2024-10-27', 'Pending'),
(9, 'alex.moore@company.com', 'Alex Moore', '555-1009', '2024-10-28', 'Rejected'),
(10, 'olivia.taylor@company.com', 'Olivia Taylor', '555-1010', '2024-10-29', 'Approved');

-- Insert data into Interview
INSERT INTO Interview (ApplicationID, Interview_Type, Status_type) VALUES
(5, 'Technical', 'Scheduled'),
(6, 'Technical', 'Scheduled'),
(7, 'Technical', 'Scheduled'),
(8, 'Technical', 'Scheduled'),
(9, 'Technical', 'Scheduled'),
(10, 'Technical', 'Scheduled');

-- Insert data into InterviewSchedule
INSERT INTO InterviewSchedule (InterviewID, StartTime, EndTime, Interview_Location, MeetingLink) VALUES
(1, '2024-11-08 09:00:00', '2024-11-08 10:00:00', 'Conference Room A', 'http://meetinglink1.com'),
(2, '2024-11-09 10:00:00', '2024-11-09 11:00:00', 'Zoom Meeting', 'http://meetinglink2.com'),
(3, '2024-11-10 11:00:00', '2024-11-10 12:00:00', 'Office', 'http://meetinglink3.com'),
(4, '2024-11-11 12:00:00', '2024-11-11 13:00:00', 'Conference Room B', 'http://meetinglink4.com'),
(5, '2024-11-12 13:00:00', '2024-11-12 14:00:00', 'Office', 'http://meetinglink5.com'),
(6, '2024-11-13 14:00:00', '2024-11-13 15:00:00', 'Zoom Meeting', 'http://meetinglink6.com');

SELECT * FROM Recruiter;
SELECT * FROM Department;
SELECT * FROM Job;
SELECT * FROM Applicant;
SELECT * FROM Applications;
SELECT * FROM Referral;

SELECT a.ApplicationID, j.Title, ap.FirstName
FROM Applications a
INNER JOIN Job j ON a.JobID = j.JobID
INNER JOIN Applicant ap ON a.ApplicantID = ap.ApplicantID;

SELECT COUNT(*) AS TotalRows FROM Job;
SELECT COUNT(*) AS TotalRows FROM Applicant;
SELECT COUNT(*) AS TotalRows FROM Applications;
SELECT COUNT(*) AS TotalRows FROM Referral;
SELECT COUNT(*) AS TotalRows FROM Interview;
SELECT COUNT(*) AS TotalRows FROM InterviewSchedule;
