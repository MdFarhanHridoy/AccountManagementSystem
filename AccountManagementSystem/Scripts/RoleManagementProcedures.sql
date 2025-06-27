USE AccountManagementDB
GO

CREATE PROCEDURE sp_AssignRoleToUser
    @UserId NVARCHAR(450),
    @RoleName NVARCHAR(256)
AS
BEGIN
    INSERT INTO AspNetUserRoles (UserId, RoleId)
    SELECT @UserId, Id FROM AspNetRoles WHERE Name = @RoleName
END
GO

CREATE PROCEDURE sp_GetUserRoles
    @UserId NVARCHAR(450)
AS
BEGIN
    SELECT r.Name 
    FROM AspNetRoles r
    INNER JOIN AspNetUserRoles ur ON r.Id = ur.RoleId
    WHERE ur.UserId = @UserId
END
GO