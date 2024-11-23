USE master;
GO

-- Create the RecruitmentSystem database if it doesn't exist
IF NOT EXISTS (SELECT name FROM sys.databases WHERE name = 'RecruitmentSystem')
BEGIN
    CREATE DATABASE RecruitmentSystem;
END
GO

USE RecruitmentSystem;
GO

-- Check and create master key if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = '##MS_DatabaseMasterKey##')
BEGIN
    CREATE MASTER KEY ENCRYPTION BY PASSWORD = 'C0mpl3x_R3cru!tmentSyst3m_2024';
    PRINT 'Master key created.';
END
ELSE
BEGIN
    PRINT 'Master key already exists.';
END
GO

-- Check and create certificate if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.certificates WHERE name = 'RecruitmentSystemCertificate')
BEGIN
    CREATE CERTIFICATE RecruitmentSystemCertificate
    WITH SUBJECT = 'Recruitment System Sensitive Data Certificate';
    PRINT 'Certificate created.';
END
ELSE
BEGIN
    PRINT 'Certificate already exists.';
END
GO

-- Check and create symmetric key if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.symmetric_keys WHERE name = 'RecruitmentSystemSymmetricKey')
BEGIN
    CREATE SYMMETRIC KEY RecruitmentSystemSymmetricKey
    WITH ALGORITHM = AES_256
    ENCRYPTION BY CERTIFICATE RecruitmentSystemCertificate;
    PRINT 'Symmetric key created.';
END
ELSE
BEGIN
    PRINT 'Symmetric key already exists.';
END
GO

-- Modify the Applicant table to add the encrypted column if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Applicant') AND name = 'EncryptedPhone')
BEGIN
    ALTER TABLE Applicant ADD EncryptedPhone VARBINARY(256);
    PRINT 'EncryptedPhone column added to Applicant table.';
END
GO

-- Modify the Recruiter table to add the encrypted column if it doesn't exist
IF NOT EXISTS (SELECT * FROM sys.columns WHERE object_id = OBJECT_ID('Recruiter') AND name = 'EncryptedPhoneNumber')
BEGIN
    ALTER TABLE Recruiter ADD EncryptedPhoneNumber VARBINARY(256);
    PRINT 'EncryptedPhoneNumber column added to Recruiter table.';
END
GO

-- Create or alter the encryption stored procedure
CREATE OR ALTER PROCEDURE sp_EncryptSensitiveData
AS
BEGIN
    BEGIN TRY
        -- Open the master key
        OPEN MASTER KEY DECRYPTION BY PASSWORD = 'C0mpl3x_R3cru!tmentSyst3m_2024';
        
        -- Open the symmetric key
        OPEN SYMMETRIC KEY RecruitmentSystemSymmetricKey
        DECRYPTION BY CERTIFICATE RecruitmentSystemCertificate;

        -- Encrypt Applicant Phone Numbers
        UPDATE Applicant
        SET EncryptedPhone = EncryptByKey(Key_GUID('RecruitmentSystemSymmetricKey'), Phone)
        WHERE Phone IS NOT NULL AND EncryptedPhone IS NULL;

        -- Encrypt Recruiter Phone Numbers
        UPDATE Recruiter
        SET EncryptedPhoneNumber = EncryptByKey(Key_GUID('RecruitmentSystemSymmetricKey'), PhoneNumber)
        WHERE PhoneNumber IS NOT NULL AND EncryptedPhoneNumber IS NULL;

        -- Close the symmetric key
        CLOSE SYMMETRIC KEY RecruitmentSystemSymmetricKey;

        -- Close the master key
        CLOSE MASTER KEY;

        PRINT 'Sensitive data encrypted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in encrypting sensitive data: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Create or alter the decryption stored procedure
CREATE OR ALTER PROCEDURE sp_DecryptSensitiveData
AS
BEGIN
    BEGIN TRY
        -- Open the master key
        OPEN MASTER KEY DECRYPTION BY PASSWORD = 'C0mpl3x_R3cru!tmentSyst3m_2024';
        
        -- Open the symmetric key
        OPEN SYMMETRIC KEY RecruitmentSystemSymmetricKey
        DECRYPTION BY CERTIFICATE RecruitmentSystemCertificate;

        -- Decrypt and display Applicant Phone Numbers
        SELECT
            ApplicantID,
            FirstName,
            LastName,
            Phone AS OriginalPhone,
            EncryptedPhone,
            CONVERT(VARCHAR(15), DecryptByKey(EncryptedPhone)) AS DecryptedPhone
        FROM Applicant
        WHERE EncryptedPhone IS NOT NULL;

        -- Decrypt and display Recruiter Phone Numbers
        SELECT
            RecruiterID,
            FirstName,
            LastName,
            PhoneNumber AS OriginalPhone,
            EncryptedPhoneNumber,
            CONVERT(VARCHAR(15), DecryptByKey(EncryptedPhoneNumber)) AS DecryptedPhoneNumber
        FROM Recruiter
        WHERE EncryptedPhoneNumber IS NOT NULL;

        -- Close the symmetric key
        CLOSE SYMMETRIC KEY RecruitmentSystemSymmetricKey;

        -- Close the master key
        CLOSE MASTER KEY;

        PRINT 'Sensitive data decrypted successfully.';
    END TRY
    BEGIN CATCH
        PRINT 'Error in decrypting sensitive data: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Create or alter the verification stored procedure
CREATE OR ALTER PROCEDURE sp_VerifyEncryption
AS
BEGIN
    BEGIN TRY
        -- Open the master key
        OPEN MASTER KEY DECRYPTION BY PASSWORD = 'C0mpl3x_R3cru!tmentSyst3m_2024';
        
        -- Open the symmetric key
        OPEN SYMMETRIC KEY RecruitmentSystemSymmetricKey
        DECRYPTION BY CERTIFICATE RecruitmentSystemCertificate;

        -- Verify Applicant Phone Encryption
        SELECT
            ApplicantID,
            FirstName,
            LastName,
            Phone AS OriginalPhone,
            EncryptedPhone,
            CONVERT(VARCHAR(15), DecryptByKey(EncryptedPhone)) AS DecryptedPhone,
            CASE
                WHEN Phone = CONVERT(VARCHAR(15), DecryptByKey(EncryptedPhone)) THEN 'Matched'
                ELSE 'Not Matched'
            END AS MatchStatus
        FROM Applicant
        WHERE EncryptedPhone IS NOT NULL;

        -- Verify Recruiter Phone Encryption
        SELECT
            RecruiterID,
            FirstName,
            LastName,
            PhoneNumber AS OriginalPhone,
            EncryptedPhoneNumber,
            CONVERT(VARCHAR(15), DecryptByKey(EncryptedPhoneNumber)) AS DecryptedPhone,
            CASE
                WHEN PhoneNumber = CONVERT(VARCHAR(15), DecryptByKey(EncryptedPhoneNumber)) THEN 'Matched'
                ELSE 'Not Matched'
            END AS MatchStatus
        FROM Recruiter
        WHERE EncryptedPhoneNumber IS NOT NULL;

        -- Close the symmetric key
        CLOSE SYMMETRIC KEY RecruitmentSystemSymmetricKey;

        -- Close the master key
        CLOSE MASTER KEY;
    END TRY
    BEGIN CATCH
        PRINT 'Error in verifying encryption: ' + ERROR_MESSAGE();
    END CATCH
END
GO

-- Execute encryption
EXEC sp_EncryptSensitiveData;
GO

-- Verify encryption
EXEC sp_VerifyEncryption;
GO

-- Optional: Decrypt and show results
EXEC sp_DecryptSensitiveData;
GO

PRINT 'Encryption setup completed for RecruitmentSystem database.';
GO