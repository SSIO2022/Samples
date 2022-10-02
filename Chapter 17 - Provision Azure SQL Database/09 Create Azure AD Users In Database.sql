--Creates an Azure AD user from a single user principal name
CREATE USER [l.penor@contoso.com] FROM EXTERNAL PROVIDER;

--Creates an Azure AD user from an Azure AD group using display name
CREATE USER [Sales Managers] FROM EXTERNAL PROVIDER;
