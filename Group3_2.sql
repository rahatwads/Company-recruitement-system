-- GROUP 3 - Company recruitement system 
--DML file




-- Insert data into Recruiter
INSERT INTO Recruiter (Email_Address, FirstName, LastName, PhoneNumber, Status_type) VALUES
('bivraajkohli@dell.com', 'bivraaj', 'Kohli', '12345671', 'Inactive'),
('shivani2@dell.com', 'shivani', 'sharma', '12345672', 'Active'),
('parnesh3@dell.com', 'parnesh', 'rao', '12345673', 'Inactive'),
('bhargav4@dell.com', 'bhargav', 'gandhi', '12345674', 'Active'),
('satwika5@dell.com', 'satwika', 'readdy', '12345675', 'Inactive'),
('ayushi6@dell.com', 'ayushi', 'ghia', '12345676', 'Active'),
('disha7@dell.com', 'disha', 'shivkkumar', '12345677', 'Inactive'),
('tharunshrey8@dell.com', 'tharunshrey', 'gurrampati', '12345677', 'Inactive'),
('aryan9@dell.com', 'aryan', 'kumar', '12345679', 'Inactive'),
('rahul10dell.com', 'rahul', 'dravid', '123456710', 'Active');

-- Insert data into Department
INSERT INTO Department (DepartmentName, Location_name, Email_Address) VALUES
('Human Resources', 'New York', 'hr@dell.com'),
('Marketing', 'Los Angeles', 'marketing@dell.com'),
('Finance', 'Chicago', 'finance@dell.com'),
('IT', 'San Francisco', 'it@dell.com'),
('Sales', 'Dallas', 'sales@dell.com'),
('Customer Service', 'Miami', 'customerservice@cdell.com'),
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


-- Insert data into Application
INSERT INTO Application (JobID, ApplicantID, SubmissionDate, Source, Status_type) VALUES
(3 ,10 ,'2024 -11 -07 ','Online ','Submitted ') ,
(7 ,1 ,'2024 -11 -07 ','Online ','Submitted ') ,
(10 ,9 ,'2024 -11 -07 ','Online ','Submitted ') ,
(9 ,9 ,'2024 -11 -07 ','Online ','Submitted ') ,
(10 ,8 ,'2024 -11 -07 ','Online ','Submitted ') ,
(3 ,9 ,'2024 -11 -07 ','Online ','Submitted ') ,
(7 ,8 ,'2024 -11 -07 ','Online ','Submitted ') ,
(3 ,1 ,'2024 -11 -07 ','Online ','Submitted ') ,
(9 ,4 ,'2024 -11 -07 ','Online ','Submitted ') ,
(5 ,7 ,'2024 -11 -07 ','Online ','Submitted ') ;

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
(5 ,'Technical ','Scheduled ') ,
(5 ,'Technical ','Scheduled ') ,
(9 ,'Technical ','Scheduled ') ,
(8 ,'Technical ','Scheduled ') ,
(8 ,'Technical ','Scheduled ') ,
(8 ,'Technical ','Scheduled ') ,
(6 ,'Technical ','Scheduled ') ,
(6 ,'Technical ','Scheduled ') ,
(9 ,'Technical ','Scheduled ') ,
(7 ,'Technical ','Scheduled ') ;

INSERT INTO InterviewSchedule (InterviewID, StartTime, EndTime, Interview_Location, MeetingLink) VALUES
(1, '2024-11-08 09:00:00', '2024-11-08 10:00:00', 'Conference Room A', 'http://meetinglink1.com'),
(2, '2024-11-09 10:00:00', '2024-11-09 11:00:00', 'Zoom Meeting', 'http://meetinglink2.com'),
(3, '2024-11-10 11:00:00', '2024-11-10 12:00:00', 'Office', 'http://meetinglink3.com'),
(4, '2024-11-11 12:00:00', '2024-11-11 13:00:00', 'Conference Room B', 'http://meetinglink4.com'),
(5, '2024-11-12 13:00:00', '2024-11-12 14:00:00', 'Office', 'http://meetinglink5.com'),
(6, '2024-11-13 14:00:00', '2024-11-13 15:00:00', 'Zoom Meeting', 'http://meetinglink6.com'),
(7, '2024-11-14 15:00:00', '2024-11-14 16:00:00', 'Conference Room C', 'http://meetinglink7.com'),
(8, '2024-11-15 16:00:00', '2024-11-15 17:00:00', 'Office', 'http://meetinglink8.com'),
(9, '2024-11-16 17:00:00', '2024-11-16 18:00:00', 'Conference Room D', 'http://meetinglink9.com'),
(10, '2024-11-17 18:00:00', '2024-11-17 19:00:00', 'Zoom Meeting', 'http://meetinglink10.com');

INSERT INTO HiringDecision (InterviewID, Hiring_Status, OfferAmount, DecisionDate) VALUES
(1, 'Accepted', 50000, '2024-11-01'),
(2, 'Rejected', 50000, '2024-11-02'),
(3, 'Accepted', 55000, '2024-11-03'),
(4, 'Rejected', 55000, '2024-11-04'),
(5, 'Accepted', 60000, '2024-11-05'),
(6, 'Accepted', 70000, '2024-11-06'),
(7, 'Rejected', 75000, '2024-11-07'),
(8, 'Accepted', 65000, '2024-11-08'),
(9, 'Accepted', 72000, '2024-11-09'),
(10, 'Rejected', 72000, '2024-11-10');

INSERT INTO InterviewFeedback (InterviewID, PanelistID, Comments, Rating, SubmissionTime) VALUES
(1, 1, 'Great candidate, very experienced.', 5, '2024-11-05 09:00:00'),
(2, 2, 'Good communication skills.', 4, '2024-11-06 09:30:00'),
(3, 3, 'Technical skills need improvement.', 3, '2024-11-06 10:00:00'),
(4, 4, 'Perfect fit for the team.', 5, '2024-11-07 11:00:00'),
(5, 5, 'Should focus more on problem-solving.', 4, '2024-11-08 10:30:00'),
(6, 6, 'Excellent presentation skills.', 5, '2024-11-09 11:00:00'),
(7, 1, 'Good overall impression.', 4, '2024-11-10 13:00:00'),
(8, 2, 'Needs to work on time management.', 3, '2024-11-11 12:30:00'),
(9, 3, 'Strong team player.', 4, '2024-11-12 14:00:00'),
(10, 4, 'Could improve interview preparation.', 2, '2024-11-13 15:00:00');

INSERT INTO RecruiterJob (RecruiterID, JobID, AssignmentDate, AssignmentStatus) VALUES
(1, 1, '2024-11-01', 'Active'),
(2, 2, '2024-11-02', 'Active'),
(3, 3, '2024-11-03', 'Completed'),
(4, 4, '2024-11-04', 'Active'),
(5, 5, '2024-11-05', 'Completed'),
(6, 6, '2024-11-06', 'Active'),
(7, 7, '2024-11-07', 'Completed'),
(8, 8, '2024-11-08', 'Active'),
(9, 9, '2024-11-09', 'Completed'),
(10, 10, '2024-11-10', 'Active');


INSERT INTO Panelist (Email_Address, FirstName, LastName, Designation, Status_type) VALUES
('alicejohnson@dell.com', 'Alice', 'Johnson', 'Senior Developer', 'Active'),
('bobsmith@dell.com', 'Bob', 'Smith', 'HR Manager', 'Active'),
('carolwilliams@dell.com', 'Carol', 'Williams', 'Project Manager', 'Active'),
('davidbrown@dell.com', 'David', 'Brown', 'Tech Lead', 'Active'),
('evedavis@dell.com', 'Eve', 'Davis', 'QA Engineer', 'Active'),
('frankmiller@dell.com', 'Frank', 'Miller', 'Product Owner', 'Active'),
('gracewilson@dell.com', 'Grace', 'Wilson', 'UX Designer', 'Active'),
('hankmoore@dell.com', 'Hank', 'Moore', 'Data Analyst', 'Active'),
('ivytaylor@dell.com', 'Ivy', 'Taylor', 'Scrum Master', 'Active'),
('jackanderson@dell.com', 'Jack', 'Anderson', 'Business Analyst', 'Active');


INSERT INTO InterviewPanelAssignment (InterviewID, PanelistID, Assignment_Role) VALUES
(1, 1, 'Lead Interviewer'),
(2, 2, 'Technical Expert'),
(3, 3, 'HR Specialist'),
(4, 4, 'Observer'),
(5, 5, 'Technical Expert'),
(6, 6, 'Lead Interviewer'),
(7, 7, 'HR Specialist'),
(8, 8, 'Observer'),
(9, 9, 'Technical Expert'),
(10, 10, 'Lead Interviewer');