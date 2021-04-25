/* 1) Write the SQL to determine which students took the most Biology credits during 1980s. */

SELECT TOP 50 WITH TIES St.StudentID, ST.StudentFname, ST.StudentLname, SUM(CO.CREDITS) AS BioCredits
FROM tblSTUDENT ST
    JOIN tblCLASS_LIST CL ON ST.StudentID = CL.StudentID
    JOIN tblCLASS CA ON CL.ClassID = CA.ClassID
    JOIN tblCOURSE CO ON CA.CourseID = CO.CourseID
    JOIN tblDEPARTMENT DE ON Co.DeptID = DE.DeptID
WHERE DE.DeptName = 'BIOLOGY'
AND CA.[Year] LIKE '198%'
GROUP BY St.StudentID, ST.StudentFname, ST.StudentLname
ORDER BY BioCredits DESC


/* 2) Write the SQL to determine the 3 colleges that had lowest average grade awarded during
1930s. */

SELECT TOP 3 WITH TIES C.CollegeID, C.CollegeName, AVG(CL.Grade) AS AvgGrade1930s
FROM tblCollege C
    JOIN tblDepartment DE ON C.CollegeID = DE.CollegeID
    JOIN tblCOURSE CO ON DE.DeptID = CO.DeptID
    JOIN tblClass CA ON CO.CourseID = CA.CourseID
    JOIN tblCLASS_LIST CL ON CA.ClassID = CL.ClassID
WHERE CA.[Year] LIKE '193%'
GROUP BY C.CollegeID, C.CollegeName
ORDER BY AvgGrade1930s ASC


/* 3) Write the SQL to determine which colleges have offered cumulative at least 800 classes of '400-level' during Spring quarters since 1983 that also had at least 10,000 students registered for a class during Winter quarter 1989? */
SELECT C.CollegeID, C.CollegeName, COUNT(CA.ClassID) AS Sp400Classes_Since1983, Winter1989Studs
FROM tblCollege C
    JOIN tblDepartment DE ON C.CollegeID = DE.CollegeID
    JOIN tblCOURSE CO ON DE.DeptID = CO.DeptID
    JOIN tblClass CA ON CO.CourseID = CA.CourseID
    JOIN tblQUARTER Q ON CA.QuarterID = Q.QuarterID
    JOIN (SELECT C.CollegeID, C.CollegeName, COUNT(DISTINCT CL.StudentID) AS Winter1989Studs
          FROM tblCollege C
              JOIN tblDepartment DE ON C.CollegeID = DE.CollegeID
              JOIN tblCOURSE CO ON DE.DeptID = CO.DeptID 
              JOIN tblClass CA ON CO.CourseID = CA.CourseID
              JOIN tblQUARTER Q ON CA.QuarterID = Q.QuarterID
              JOIN tblCLASS_LIST CL ON CA.ClassID = CL.ClassID
              JOIN tblStudent ST ON CL.StudentID = ST.StudentID
          WHERE CA.[Year] = '1989'
          AND Q.QuarterName = 'Winter'
          GROUP BY C.CollegeID, C.CollegeName
          HAVING COUNT(*) >= 10000) AS subq1 ON C.CollegeID = subq1.CollegeID
WHERE CO.CourseNumber LIKE '%4__'
AND Q.QuarterName = 'Spring'
AND CA.[YEAR] >= '1983'
GROUP BY C.CollegeID, C.CollegeName, Winter1989Studs
HAVING COUNT(*) >= 800
ORDER BY C.CollegeID ASC


/* 4) Write the SQL to determine the Locations on campus that offered no more than 80 Mathematics courses during the 1940's. */

SELECT DISTINCT LO.LocationID, LO.LocationName, COUNT(*) as MathClasses1940s
FROM tblLOCATION LO
    JOIN tblBUILDING BU ON LO.LocationID = BU.LocationID
    JOIN tblCLASSROOM CR ON BU.BuildingID = CR.BuildingID
    JOIN tblCLASS CA ON CR.ClassroomID = CA.ClassroomID
    JOIN tblCOURSE CO ON CA.CourseID = CO.CourseID
    JOIN tblDEPARTMENT DE ON CO.DeptID = DE.DeptID
WHERE DE.DeptName = 'Mathematics'
AND CA.[Year] >= '1940' AND CA.[YEAR] < '1950'
GROUP BY LO.LocationID, LO.LocationName
HAVING COUNT(*) <= 80
ORDER BY MathClasses1940s DESC


/* 5) Write the SQL to determine the Locations on campus that offered at least 20 History courses during the 1970s. */

SELECT DISTINCT LO.LocationID, LO.LocationName, COUNT(CO.CourseName) as HISTClasses1970s
FROM tblLOCATION LO
    JOIN tblBUILDING BU ON LO.LocationID = BU.LocationID
    JOIN tblCLASSROOM CR ON BU.BuildingID = CR.BuildingID
    JOIN tblCLASS CA ON CR.ClassroomID = CA.ClassroomID
    JOIN tblCOURSE CO ON CA.CourseID = CO.CourseID
    JOIN tblDEPARTMENT DE ON CO.DeptID = DE.DeptID
WHERE DE.DeptName = 'HISTORY'
AND CA.[Year] LIKE '197%'
GROUP BY LO.LocationID, LO.LocationName
HAVING COUNT(*) >= 20
ORDER BY HISTClasses1970s DESC


/* 6) Write the SQL to return the Locations that meet all conditions in questions #4 and #5 above; try and return BOTH counts in a single query(!!). */

SELECT DISTINCT LO.LocationID, LO.LocationName, COUNT(*) as HISTClasses1970s, MathClasses1940s
FROM tblLOCATION LO
    JOIN tblBUILDING BU ON LO.LocationID = BU.LocationID
    JOIN tblCLASSROOM CR ON BU.BuildingID = CR.BuildingID
    JOIN tblCLASS CA ON CR.ClassroomID = CA.ClassroomID
    JOIN tblCOURSE CO ON CA.CourseID = CO.CourseID
    JOIN tblDEPARTMENT DE ON CO.DeptID = DE.DeptID
    JOIN(SELECT DISTINCT LO.LocationID, LO.LocationName, COUNT(*) as MathClasses1940s
          FROM tblLOCATION LO
              JOIN tblBUILDING BU ON LO.LocationID = BU.LocationID
              JOIN tblCLASSROOM CR ON BU.BuildingID = CR.BuildingID
              JOIN tblCLASS CA ON CR.ClassroomID = CA.ClassroomID
              JOIN tblCOURSE CO ON CA.CourseID = CO.CourseID
              JOIN tblDEPARTMENT DE ON CO.DeptID = DE.DeptID
          WHERE DE.DeptName = 'Mathematics'
          AND CA.[Year] >= '1940' AND CA.[YEAR] < '1950'
          GROUP BY LO.LocationID, LO.LocationName
          HAVING COUNT(*) <= 80) AS subq1 ON LO.LocationID = subq1.LocationID
WHERE DE.DeptName = 'HISTORY'
AND CA.[Year] LIKE '197%'
GROUP BY LO.LocationID, LO.LocationName, MathClasses1940s
HAVING COUNT(*) >= 20
