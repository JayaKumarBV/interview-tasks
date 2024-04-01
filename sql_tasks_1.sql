

CREATE TABLE [Emp] (
    [EmpId] INT NOT NULL IDENTITY(1, 1),
    [Name] VARCHAR(255) NULL,
    [DeptId] INT NULL,
    [Salary] INT NULL,
    PRIMARY KEY ([EmpID])
);
GO
TRUNCATE TABLE [Emp]
INSERT INTO [Emp] ([Name], DeptId, Salary)
VALUES
  ('Britanni',3,1000),
  ('Julian',2,2000),
  ('Dolan',3,3000),
  ('Jonah',4,4000),
  ('Fulton',2,5000),
  ('Scarlett',4,1000),
  ('Bernard',2,2000),
  ('Chancellor',1,3000),
  ('Dalton',4,4500),
  ('Len',1,5000),
  ('Bree',4,1000),
  ('Cooper',1,2000),
  ('Nora',4,3000),
  ('Gareth',3,4000),
  ('Beau',2,5000);


  SELECT *,
ROW_NUMBER() OVER(PARTITION BY DeptId ORDER BY Salary) AS RowNumber,
      RANK() OVER(PARTITION BY DeptId ORDER BY Salary) AS [Rank],
DENSE_RANK() OVER(PARTITION BY DeptId ORDER BY Salary) AS [DenseRank]
FROM [dbo].[Emp]


select * from (
SELECT * ,
ROW_NUMBER() OVER(PARTITION BY deptid order by salary desc) as RowNumber
from dbo.emp) as a
where a.rownumber = 3



select * from emp where salary between 1001 and 10000

SELECT CONCAT(10,10)


CREATE TABLE #TEMP(
ID INT IDENTITY(1,1),
NUM INT
)
INSERT INTO #TEMP(NUM) VALUES (1)
INSERT INTO #TEMP(NUM) VALUES (1)
INSERT INTO #TEMP(NUM) VALUES (1)
INSERT INTO #TEMP(NUM) VALUES (2)
INSERT INTO #TEMP(NUM) VALUES (1)
INSERT INTO #TEMP(NUM) VALUES (2)
INSERT INTO #TEMP(NUM) VALUES (2)

SELECT * FROM #TEMP
/* Write your T-SQL query statement below */

	/* Write your T-SQL query statement below */

DECLARE @ID INT = 1;
	DECLARE @MAXID INT = (SELECT MAX(ID) FROM #TEMP);
	DECLARE @num1 INT,@num2 INT,@num3 INT ;
	declare  @LOCAL_TABLEVARIABLE TABLE (ConsecutiveNums INT)
	WHILE (@MAXID >=@ID )
	BEGIN
		SELECT @num1=num FROM #TEMP WHERE ID = @ID;
		SELECT @num2=num FROM #TEMP WHERE ID = @ID+1;
		SELECT @num3=num FROM #TEMP WHERE ID = @ID+2;

	IF (@num1=@num2)
		BEGIN
			IF(@num2=@num3)
			BEGIN
				IF(@num3=@num1)
					BEGIN
					INSERT INTO @LOCAL_TABLEVARIABLE  VALUES (@num1)
					END
			END
		END
	SET @num1=NULL
	SET @num2=NULL
	SET @num3=NULL
	SET @ID = @ID+1
	END
	SELECT * FROM @LOCAL_TABLEVARIABLE 




	WITH consecutive_group AS (
  SELECT
    num,
    CASE
      WHEN
        LAG(num, 2) OVER (ORDER BY id) = LAG(num, 1) OVER (ORDER BY id)
        AND LAG(num, 1) OVER (ORDER BY id) = num
      THEN 1
      WHEN
        LAG(num, 1) OVER (ORDER BY id) = num
        AND num = LEAD(num, 1) OVER (ORDER BY id)
      THEN 1
      WHEN
        num = LEAD(num, 1) OVER (ORDER BY id)
        AND LEAD(num, 1) OVER (ORDER BY id) = LEAD(num, 2) OVER (ORDER BY id)
      THEN 1
      ELSE 0
    END [is_valid]
  FROM #TEMP
)
SELECT DISTINCT num [ConsecutiveNums]
FROM consecutive_group
WHERE is_valid = 1

select num,
LAG(num, 1)   OVER (ORDER BY id) ,
LAG(num, 2) OVER (ORDER BY id),
LAG(num, 1) OVER (ORDER BY id),
LEAD(num, 1) OVER (ORDER BY id),
LEAD(num, 1) OVER (ORDER BY id),
LEAD(num, 1) OVER (ORDER BY id),
LEAD(num, 2) OVER (ORDER BY id)

FROM #TEMP