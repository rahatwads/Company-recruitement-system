-- Use the RecruitmentSystem database
USE RecruitmentSystem;
GO

-- =============================================
-- VIEWS
-- =============================================

-- 1. View for Job Application Status Overview
CREATE OR ALTER VIEW vw_ApplicationStatusOverview AS
SELECT 
    j.Title AS JobTitle,
    d.DepartmentName,
    COUNT(a.ApplicationID) AS TotalApplications,
    SUM(CASE WHEN a.Status_type = 'Submitted' THEN 1 ELSE 0 END) AS PendingApplications,
    j.SalaryMin,
    j.SalaryMax,
    j.Deadline
FROM Job j
LEFT JOIN Applications a ON j.JobID = a.JobID
LEFT JOIN Department d ON j.DepartmentID = d.DepartmentID
GROUP BY j.Title, d.DepartmentName, j.SalaryMin, j.SalaryMax, j.Deadline;
GO

SELECT * 
FROM vw_ApplicationStatusOverview;
GO




-- 2. View for Interview Schedule Details
CREATE OR ALTER VIEW vw_InterviewScheduleDetails AS
SELECT 
    i.InterviewID,
    a.FirstName + ' ' + a.LastName AS ApplicantName,
    j.Title AS JobTitle,
    [is].StartTime,
    [is].EndTime,
    [is].Interview_Location,
    i.Interview_Type,
    i.Status_type AS InterviewStatus,
    p.FirstName + ' ' + p.LastName AS PanelistName
FROM Interview i
JOIN Applications app ON i.ApplicationID = app.ApplicationID
JOIN Applicant a ON app.ApplicantID = a.ApplicantID
JOIN Job j ON app.JobID = j.JobID
JOIN InterviewSchedule [is] ON i.InterviewID = [is].InterviewID
LEFT JOIN InterviewPanelAssignment ipa ON i.InterviewID = ipa.InterviewID
LEFT JOIN Panelist p ON ipa.PanelistID = p.PanelistID;
GO

SELECT * 
FROM vw_InterviewScheduleDetails;
GO

-- 3. View for Referral Analytics
CREATE OR ALTER VIEW vw_ReferralAnalytics AS
SELECT 
    d.DepartmentName,
    j.Title AS JobTitle,
    COUNT(r.ReferralID) AS TotalReferrals,
    SUM(CASE WHEN r.Status_type = 'Approved' THEN 1 ELSE 0 END) AS ApprovedReferrals,
    SUM(CASE WHEN r.Status_type = 'Rejected' THEN 1 ELSE 0 END) AS RejectedReferrals,
    SUM(CASE WHEN r.Status_type = 'Pending' THEN 1 ELSE 0 END) AS PendingReferrals
FROM Job j
JOIN Applications a ON j.JobID = a.JobID
JOIN Department d ON j.DepartmentID = d.DepartmentID
LEFT JOIN Referral r ON a.ApplicantID = r.ApplicantID
GROUP BY d.DepartmentName, j.Title;
GO

SELECT * 
FROM vw_ReferralAnalytics;
GO

-- =============================================
-- STORED PROCEDURES
-- =============================================

-- 1. Stored Procedure to Schedule Interview
CREATE OR ALTER PROCEDURE sp_ScheduleInterview
    @ApplicationID INT,
    @InterviewType VARCHAR(50),
    @StartTime DATETIME,
    @EndTime DATETIME,
    @Location VARCHAR(100),
    @MeetingLink VARCHAR(255),
    @Success BIT OUTPUT,
    @Message VARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        BEGIN TRANSACTION;
            -- Create interview record
            INSERT INTO Interview (ApplicationID, Interview_Type, Status_type)
            VALUES (@ApplicationID, @InterviewType, 'Scheduled');
            
            DECLARE @InterviewID INT = SCOPE_IDENTITY();
            
            -- Create interview schedule
            INSERT INTO InterviewSchedule (InterviewID, StartTime, EndTime, Interview_Location, MeetingLink)
            VALUES (@InterviewID, @StartTime, @EndTime, @Location, @MeetingLink);
            
            -- Update application status
            UPDATE Applications 
            SET Status_type = 'Interview_Scheduled'
            WHERE ApplicationID = @ApplicationID;
            
            SET @Success = 1;
            SET @Message = 'Interview scheduled successfully';
        COMMIT TRANSACTION;
    END TRY
    BEGIN CATCH
        IF @@TRANCOUNT > 0
            ROLLBACK TRANSACTION;
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH;
END;
GO


DECLARE @Success BIT, @Message VARCHAR(255);

EXEC sp_ScheduleInterview
    @ApplicationID = 101, -- Replace with an actual ApplicationID
    @InterviewType = 'Technical',
    @StartTime = '2024-12-01 10:00:00',
    @EndTime = '2024-12-01 11:00:00',
    @Location = 'Conference Room A',
    @MeetingLink = 'https://example.com/interview',
    @Success = @Success OUTPUT,
    @Message = @Message OUTPUT;

SELECT @Success AS Success, @Message AS Message;
GO

-- 2. Stored Procedure to Process Referral
CREATE OR ALTER PROCEDURE sp_ProcessReferral
    @ApplicantID INT,
    @ReferralEmail VARCHAR(255),
    @ReferralName VARCHAR(100),
    @ReferralPhone VARCHAR(15),
    @Status VARCHAR(50),
    @Success BIT OUTPUT,
    @Message VARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validate applicant exists
        IF NOT EXISTS (SELECT 1 FROM Applicant WHERE ApplicantID = @ApplicantID)
        BEGIN
            SET @Success = 0;
            SET @Message = 'Invalid ApplicantID';
            RETURN;
        END

        -- Insert referral
        INSERT INTO Referral (ApplicantID, ReferralEmail, ReferralName, ReferralPhone, ReferralDate, Status_type)
        VALUES (@ApplicantID, @ReferralEmail, @ReferralName, @ReferralPhone, GETDATE(), @Status);

        SET @Success = 1;
        SET @Message = 'Referral processed successfully';
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH;
END;
GO


DECLARE @Success BIT, @Message VARCHAR(255);

EXEC sp_ProcessReferral
    @ApplicantID = 202, -- Replace with an actual ApplicantID
    @ReferralEmail = 'referral@example.com',
    @ReferralName = 'John Doe',
    @ReferralPhone = '1234567890',
    @Status = 'Pending',
    @Success = @Success OUTPUT,
    @Message = @Message OUTPUT;

SELECT @Success AS Success, @Message AS Message;
GO
-- 3. Stored Procedure to Generate Interview Feedback
CREATE OR ALTER PROCEDURE sp_SubmitInterviewFeedback
    @InterviewID INT,
    @Comments TEXT,
    @Rating INT,
    @Success BIT OUTPUT,
    @Message VARCHAR(255) OUTPUT
AS
BEGIN
    SET NOCOUNT ON;
    BEGIN TRY
        -- Validate interview exists
        IF NOT EXISTS (SELECT 1 FROM Interview WHERE InterviewID = @InterviewID)
        BEGIN
            SET @Success = 0;
            SET @Message = 'Invalid InterviewID';
            RETURN;
        END

        -- Validate rating
        IF @Rating < 1 OR @Rating > 5
        BEGIN
            SET @Success = 0;
            SET @Message = 'Rating must be between 1 and 5';
            RETURN;
        END

        -- Insert feedback
        INSERT INTO InterviewFeedback (InterviewID, Comments, Rating, SubmissionTime)
        VALUES (@InterviewID, @Comments, @Rating, GETDATE());

        SET @Success = 1;
        SET @Message = 'Feedback submitted successfully';
    END TRY
    BEGIN CATCH
        SET @Success = 0;
        SET @Message = ERROR_MESSAGE();
    END CATCH;
END;
GO


DECLARE @Success BIT, @Message VARCHAR(255);

EXEC sp_SubmitInterviewFeedback
    @InterviewID = 301, -- Replace with an actual InterviewID
    @Comments = 'Excellent performance during the interview.',
    @Rating = 5,
    @Success = @Success OUTPUT,
    @Message = @Message OUTPUT;

SELECT @Success AS Success, @Message AS Message;
GO
-- =============================================
-- USER-DEFINED FUNCTIONS
-- =============================================

-- 1. Function to Calculate Average Interview Rating by Job
CREATE OR ALTER FUNCTION fn_GetJobAverageRating
(
    @JobID INT
)
RETURNS DECIMAL(3,2)
AS
BEGIN
    DECLARE @AvgRating DECIMAL(3,2);
    
    SELECT @AvgRating = AVG(CAST(f.Rating AS DECIMAL(3,2)))
    FROM Job j
    JOIN Applications a ON j.JobID = a.JobID
    JOIN Interview i ON a.ApplicationID = i.ApplicationID
    JOIN InterviewFeedback f ON i.InterviewID = f.InterviewID
    WHERE j.JobID = @JobID;
    
    RETURN ISNULL(@AvgRating, 0);
END;
GO

DECLARE @JobID INT = 101; -- Replace with your actual JobID
SELECT dbo.fn_GetJobAverageRating(@JobID) AS AverageRating;
GO
-- 2. Function to Get Application Status History
CREATE OR ALTER FUNCTION fn_GetApplicationHistory
(
    @ApplicationID INT
)
RETURNS TABLE
AS
RETURN
(
    SELECT 
        a.ApplicationID,
        a.SubmissionDate,
        a.Status_type AS CurrentStatus,
        i.Interview_Type,
        i.Status_type AS InterviewStatus,
        f.Rating AS InterviewRating,
        h.Hiring_Status,
        h.OfferAmount
    FROM Applications a
    LEFT JOIN Interview i ON a.ApplicationID = i.ApplicationID
    LEFT JOIN InterviewFeedback f ON i.InterviewID = f.InterviewID
    LEFT JOIN HiringDecision h ON i.InterviewID = h.InterviewID
    WHERE a.ApplicationID = @ApplicationID
);
GO

DECLARE @ApplicationID INT = 202; -- Replace with your actual ApplicationID
SELECT * 
FROM dbo.fn_GetApplicationHistory(@ApplicationID);
GO


-- 3. Function to Calculate Department Hiring Success Rate
CREATE OR ALTER FUNCTION fn_DepartmentHiringSuccessRate
(
    @DepartmentID INT,
    @StartDate DATE,
    @EndDate DATE
)
RETURNS DECIMAL(5,2)
AS
BEGIN
    DECLARE @SuccessRate DECIMAL(5,2);
    DECLARE @TotalApplications INT;
    DECLARE @SuccessfulHires INT;
    
    SELECT 
        @TotalApplications = COUNT(DISTINCT a.ApplicationID),
        @SuccessfulHires = COUNT(DISTINCT CASE WHEN h.Hiring_Status = 'Accepted' THEN a.ApplicationID END)
    FROM Applications a
    JOIN Job j ON a.JobID = j.JobID
    LEFT JOIN Interview i ON a.ApplicationID = i.ApplicationID
    LEFT JOIN HiringDecision h ON i.InterviewID = h.InterviewID
    WHERE j.DepartmentID = @DepartmentID
    AND a.SubmissionDate BETWEEN @StartDate AND @EndDate;
    
    SET @SuccessRate = CASE 
        WHEN @TotalApplications > 0 THEN 
            (@SuccessfulHires * 100.0) / @TotalApplications
        ELSE 0
    END;
    
    RETURN @SuccessRate;
END;
GO

DECLARE @DepartmentID INT = 1; -- Replace with your actual DepartmentID
DECLARE @StartDate DATE = '2024-01-01'; -- Replace with your start date
DECLARE @EndDate DATE = '2024-11-30'; -- Replace with your end date

SELECT dbo.fn_DepartmentHiringSuccessRate(@DepartmentID, @StartDate, @EndDate) AS HiringSuccessRate;
GO
--OR
SELECT dbo.fn_DepartmentHiringSuccessRate(1, '2024-01-01', '2024-11-30') AS HiringSuccessRate;
GO


-- =============================================
-- TRIGGERS
-- =============================================

-- Trigger to Update Application Status on Interview Schedule
CREATE OR ALTER TRIGGER trg_UpdateApplicationStatus
ON InterviewSchedule
AFTER INSERT
AS
BEGIN
    SET NOCOUNT ON;
    
    UPDATE a
    SET Status_type = 'Interview_Scheduled'
    FROM Applications a
    JOIN Interview i ON a.ApplicationID = i.ApplicationID
    JOIN inserted ins ON i.InterviewID = ins.InterviewID;
END;
GO

SELECT a.ApplicationID, a.Status_type, j.Title, ap.FirstName
FROM Applications a
INNER JOIN Job j ON a.JobID = j.JobID
INNER JOIN Applicant ap ON a.ApplicantID = ap.ApplicantID;



