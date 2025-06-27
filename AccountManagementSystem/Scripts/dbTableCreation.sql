CREATE TABLE ChartOfAccounts (
    AccountId INT PRIMARY KEY IDENTITY(1,1),
    AccountCode NVARCHAR(50) NOT NULL,
    AccountName NVARCHAR(100) NOT NULL,
    ParentAccountId INT NULL,
    AccountType NVARCHAR(50) NOT NULL,
    IsActive BIT DEFAULT 1,
    CreatedDate DATETIME DEFAULT GETDATE(),
    FOREIGN KEY (ParentAccountId) REFERENCES ChartOfAccounts(AccountId)
);