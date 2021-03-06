SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Category]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Category](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](50) NULL,
	[ParentID] [int] NULL,
	[ShowOrder] [int] NULL,
	[Remark] [text] NULL,
 CONSTRAINT [PK_Category] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserInfo]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserInfo](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Username] [varchar](32) NULL,
	[Password] [varchar](255) NULL,
	[Email] [varchar](200) NULL,
 CONSTRAINT [PK_UserInfo] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Role]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Role](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[RoleName] [varchar](50) NULL,
 CONSTRAINT [PK_Role] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Fu_FilterUsername]') AND type in (N'FN', N'IF', N'TF', N'FS', N'FT'))
BEGIN
execute dbo.sp_executesql @statement = N'CREATE FUNCTION [dbo].[Fu_FilterUsername]
(
	@Username varchar(200)
)

RETURNS varchar(200)

AS

BEGIN
	RETURN UPPER(@Username)
END

' 
END

GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[UserRole]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[UserRole](
	[UserID] [int] NOT NULL,
	[RoleID] [int] NOT NULL,
 CONSTRAINT [PK_UserRole] PRIMARY KEY CLUSTERED 
(
	[UserID] ASC,
	[RoleID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Order]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Order](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderNo] [varchar](50) NULL,
	[UserID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_Order] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Product]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[Product](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[Name] [varchar](200) NULL,
	[Remark] [text] NULL,
	[Price] [money] NULL,
	[Stock] [int] NULL,
	[SaleNumber] [int] NULL,
	[PictureUrl] [varchar](255) NULL,
	[CategoryID] [int] NULL,
	[UserID] [int] NULL,
	[CreateDate] [datetime] NULL,
	[LasterDate] [datetime] NULL,
	[ViewCount] [int] NULL CONSTRAINT [DF_Product_ViewCount]  DEFAULT ((0)),
	[Status] [tinyint] NULL,
 CONSTRAINT [PK_Product] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY] TEXTIMAGE_ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[OrderItem]') AND type in (N'U'))
BEGIN
CREATE TABLE [dbo].[OrderItem](
	[ID] [int] IDENTITY(1,1) NOT NULL,
	[OrderID] [int] NULL,
	[ProductID] [int] NULL,
	[Number] [int] NULL,
 CONSTRAINT [PK_OrderItem] PRIMARY KEY CLUSTERED 
(
	[ID] ASC
)WITH (IGNORE_DUP_KEY = OFF) ON [PRIMARY]
) ON [PRIMARY]
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetProductByCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetProductByCategory]
(
	@CategoryID int
) 

AS
	
SELECT
	[Product].*,
	Category.Name AS CategoryName,
	[UserInfo].UserName
FROM
	[Product]
INNER JOIN
	Category
	On [Product].CategoryID = Category.ID
INNER JOIN
	[UserInfo]
	ON [UserInfo].ID = [Product].UserID

WHERE
	[Product].CategoryID = @CategoryID
ORDER BY
	LasterDate DESC


' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetUserLogin]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetUserLogin]
(
	@Username varchar(50),
	@Password varchar(255)
)
AS

SELECT
	ID
FROM
	[UserInfo]
WHERE
	Username = @Username AND Password = @Password
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetUsersAndRoles]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetUsersAndRoles]
	
AS

SELECT TOP 10 * FROM UserInfo
SELECT * FROM Role
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetUserAndRole]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetUserAndRole]
	
AS

SELECT * FROM UserInfo

SELECT * FROM Role
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_AddCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_AddCategory]
(
	@Name varchar(200),
	@ParentID int,
	@Remark text
)
AS

DECLARE @Count int
SET
	@Count = ISNULL((SELECT COUNT(*) FROM Category WHERE ParentID = @ParentID),0)

INSERT INTO
	Category
	(Name,ParentID,ShowOrder,Remark)
	VALUES
	(@Name,@ParentID,@Count + 1,@Remark)
	
RETURN @@Identity
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_UpdateCategoryOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_UpdateCategoryOrder]
(
   @ID int,
   @MoveFlag varchar(20)
)
AS
	
DECLARE @UpdateOrder int
DECLARE @ParentID int

SET @UpdateOrder =(SELECT ShowOrder FROM Category WHERE ID = @ID)
SET @ParentID =(SELECT ParentID FROM Category WHERE ID = @ID) 

BEGIN TRAN
IF @MoveFlag = ''up''
   BEGIN
     DECLARE @LitterID int     
     SET @LitterID =(
		SELECT ID FROM Category
		WHERE ParentID = @ParentID AND ShowOrder = @UpdateOrder -1
		)
       
     UPDATE
         Category         
     SET
         ShowOrder = @UpdateOrder -1         
     WHERE
         ID = @ID
         
     UPDATE
         Category         
     SET
         ShowOrder = @UpdateOrder         
     WHERE
         ID = @LitterID
   END
ELSE
    IF @MoveFlag = ''down'' 
       BEGIN
          DECLARE @GreaterID int     
          SET @GreaterID =(
				SELECT ID FROM Category                  
				WHERE ParentID = @ParentID AND ShowOrder = @UpdateOrder + 1
				)
       
          UPDATE
              Category         
          SET
              ShowOrder = @UpdateOrder + 1         
          WHERE
              ID = @ID
         
          UPDATE
              Category         
          SET
              ShowOrder = @UpdateOrder         
          WHERE
              ID = @GreaterID
      END      
COMMIT TRAN
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetCategorys]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetCategorys]

AS

SELECT
	A.ID,
	A.Name,
	A.ParentID,
	A.ShowOrder,
	A.Remark,
	ISNULL((SELECT Name FROM Category AS B WHERE A.ParentID = B.ID),null) AS ParentName,
	ISNULL((SELECT COUNT(*) FROM Category AS C WHERE A.ID = c.ParentID),0) AS SubCount,
	ISNULL((SELECT COUNT(*) FROM Category AS D WHERE A.ParentID = D.ParentID),0) AS SiblingCount
	
FROM
	Category AS A

ORDER BY
	ParentID,ShowOrder 
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_DeleteCategory]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_DeleteCategory]
(
	@ID int
)
AS

DECLARE @ShowOrder int
SET @ShowOrder = ISNULL((SELECT ShowOrder FROM Category WHERE ID = @ID),0)

DECLARE @ParentID int
SET @ParentID = (ISNULL((SELECT @ParentID FROM Category WHERE ID = @ID),-1))

DECLARE @Count int

BEGIN TRAN
	UPDATE
		Category
	SET
		ShowOrder = ShowOrder - 1
	WHERE
		Showorder > @ShowOrder AND ParentID = @ParentID

	DELETE
		Category
	WHERE
		ID = @ID
	
	SET
		@Count = @@ROWCOUNT
		
COMMIT TRAN
	
RETURN @Count
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetOrderByUser]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetOrderByUser]
(
	@UserID int
)
AS

SELECT
	[Order].*,
	(
		SELECT SUM(OrderItem.Number)
		FROM OrderItem
		INNER JOIN [Order] ON OrderItem.OrderID = [Order].ID
		WHERE [Order].UserID = @UserID
	) AS TotalNumber,
	(
		SELECT SUM(OrderItem.Number * [Product].Price)
		FROM OrderItem
		INNER JOIN [Product] ON OrderItem.ProductID = [Product].ID
	) AS TotalMoney
	
FROM
	[Order]

WHERE
	[Order].UserID = @UserID

ORDER BY [Order].CreateDate DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetOrders]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetOrders]

AS

SELECT
	[Order].*,
	(
		SELECT SUM(OrderItem.Number)
		FROM OrderItem
		INNER JOIN [Order] ON [OrderItem].OrderID = [Order].ID		
	) AS TotalNumber,
	(
		SELECT SUM(OrderItem.Number * [Product].Price)
		FROM OrderItem
		INNER JOIN [Product] ON OrderItem.ProductID = [Product].ID
	) AS TotalMoney
	
FROM
	[Order]

ORDER BY [Order].CreateDate DESC
' 
END
GO
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO
IF NOT EXISTS (SELECT * FROM sys.objects WHERE object_id = OBJECT_ID(N'[dbo].[Pr_GetOrderItemByOrder]') AND type in (N'P', N'PC'))
BEGIN
EXEC dbo.sp_executesql @statement = N'CREATE PROCEDURE [dbo].[Pr_GetOrderItemByOrder]
(
	@OrderID int
)
AS

SELECT
	OrderItem.*,
	[Product].Name,
	[Product].Price

FROM OrderItem
INNER JOIN [Product] ON OrderItem.ProductID = [Product].ID

WHERE
	OrderItem.OrderID = @OrderID' 
END
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_Role]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_Role] FOREIGN KEY([RoleID])
REFERENCES [dbo].[Role] ([ID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_UserRole_UserInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[UserRole]'))
ALTER TABLE [dbo].[UserRole]  WITH CHECK ADD  CONSTRAINT [FK_UserRole_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([ID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Order_UserInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[Order]'))
ALTER TABLE [dbo].[Order]  WITH CHECK ADD  CONSTRAINT [FK_Order_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([ID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_Category]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_Category] FOREIGN KEY([CategoryID])
REFERENCES [dbo].[Category] ([ID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_Product_UserInfo]') AND parent_object_id = OBJECT_ID(N'[dbo].[Product]'))
ALTER TABLE [dbo].[Product]  WITH CHECK ADD  CONSTRAINT [FK_Product_UserInfo] FOREIGN KEY([UserID])
REFERENCES [dbo].[UserInfo] ([ID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderItem_Order]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderItem]'))
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Order] FOREIGN KEY([OrderID])
REFERENCES [dbo].[Order] ([ID])
GO
IF NOT EXISTS (SELECT * FROM sys.foreign_keys WHERE object_id = OBJECT_ID(N'[dbo].[FK_OrderItem_Product]') AND parent_object_id = OBJECT_ID(N'[dbo].[OrderItem]'))
ALTER TABLE [dbo].[OrderItem]  WITH CHECK ADD  CONSTRAINT [FK_OrderItem_Product] FOREIGN KEY([ProductID])
REFERENCES [dbo].[Product] ([ID])
