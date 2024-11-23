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

EXEC sp_DecryptSensitiveData;