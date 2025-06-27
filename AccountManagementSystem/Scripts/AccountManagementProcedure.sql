CREATE PROCEDURE sp_ManageChartOfAccounts
    @Action VARCHAR(20),
    @AccountId INT = NULL,
    @AccountCode NVARCHAR(50) = NULL,
    @AccountName NVARCHAR(100) = NULL,
    @ParentAccountId INT = NULL,
    @AccountType NVARCHAR(50) = NULL,
    @IsActive BIT = NULL
AS
BEGIN
    IF @Action = 'Create'
    BEGIN
        INSERT INTO ChartOfAccounts (AccountCode, AccountName, ParentAccountId, AccountType, IsActive)
        VALUES (@AccountCode, @AccountName, @ParentAccountId, @AccountType, @IsActive)
        
        SELECT SCOPE_IDENTITY() AS AccountId
    END
    ELSE IF @Action = 'Update'
    BEGIN
        UPDATE ChartOfAccounts
        SET AccountCode = @AccountCode,
            AccountName = @AccountName,
            ParentAccountId = @ParentAccountId,
            AccountType = @AccountType,
            IsActive = @IsActive
        WHERE AccountId = @AccountId
    END
    ELSE IF @Action = 'Delete'
    BEGIN
        UPDATE ChartOfAccounts
        SET IsActive = 0
        WHERE AccountId = @AccountId
    END
    ELSE IF @Action = 'GetAll'
    BEGIN
        SELECT * FROM ChartOfAccounts WHERE IsActive = 1
    END
    ELSE IF @Action = 'GetById'
    BEGIN
        SELECT * FROM ChartOfAccounts WHERE AccountId = @AccountId AND IsActive = 1
    END
END
GO