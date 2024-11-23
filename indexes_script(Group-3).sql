USE RecruitmentSystem;
GO

-- 1. Index for Job Search
CREATE NONCLUSTERED INDEX IX_Job_Title_Status
ON Job (Title, Status_type)
INCLUDE (SalaryMin, SalaryMax, Deadline);
GO

SELECT Title, Status_type, SalaryMin, SalaryMax, Deadline
FROM Job
WHERE Title LIKE '%Developer%' AND Status_type = 'Open';


-- 2. Index for Application Tracking
CREATE NONCLUSTERED INDEX IX_Applications_Status
ON Applications (Status_type, SubmissionDate)
INCLUDE (JobID, ApplicantID);
GO

SELECT Status_type, SubmissionDate, JobID, ApplicantID
FROM Applications
WHERE Status_type = 'Pending' AND SubmissionDate >= '2024-01-01';


-- 3. Index for Interview Schedule
CREATE NONCLUSTERED INDEX IX_InterviewSchedule_DateTime
ON InterviewSchedule (StartTime, EndTime)
INCLUDE (InterviewID, Interview_Location, MeetingLink);
GO

SELECT StartTime, EndTime, InterviewID, Interview_Location, MeetingLink
FROM InterviewSchedule
WHERE StartTime BETWEEN '2024-11-01 08:00:00' AND '2024-11-30 18:00:00';


-- 4. Index for Applicant Search
CREATE NONCLUSTERED INDEX IX_Applicant_Name
ON Applicant (LastName, FirstName)
INCLUDE (Email, Phone);
GO

SELECT LastName, FirstName, Email, Phone
FROM Applicant
WHERE LastName LIKE 'S%' AND FirstName LIKE 'J%';


-- 5. Index for Referral Tracking
CREATE NONCLUSTERED INDEX IX_Referral_Status
ON Referral (Status_type, ReferralDate)
INCLUDE (ApplicantID, ReferralName, ReferralEmail);
GO

SELECT Status_type, ReferralDate, ApplicantID, ReferralName, ReferralEmail
FROM Referral
WHERE Status_type = 'Accepted' AND ReferralDate > '2024-01-01';
