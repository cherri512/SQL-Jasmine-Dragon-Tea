/* 1.) Which colleges have at least 1 department that meet the following two conditions: have at
least 4 current staff that have been in the same position for 2 years, have had more than
10,000 students register for one course since 2007. */

SELECT Distinct CO.CollegeID, CO.CollegeName
FROM tblCollege CO
    JOIN (SELECT DE.DeptID, DE.DeptName, CO.CollegeID, COUNT(*) AS CurrentStaff_2years
          FROM tblDEPARTMENT DE
              JOIN tblSTAFF_Position SP on DE.DeptID = SP.DeptID
              JOIN tblStaff ST on SP.StaffID = ST.StaffID
              JOIN tblPOSITION PO on SP.PositionID = PO.PositionID
              JOIN tblCollege CO on DE.CollegeID = CO.CollegeID
          WHERE SP.EndDate IS NULL
          AND SP.BeginDate < DateADD(year, -2, GetDate())
          GROUP BY DE.DeptID, DE.DeptName, CO.CollegeID
          HAVING Count(*) >= 4) AS subq1 ON CO.CollegeID = subq1.CollegeID
    JOIN (SELECT DE.DeptID, DE.DeptName, CO.CollegeID, COUNT(DISTINCT CL.StudentID) AS DistinctStudents2007
          FROM tblCollege CO
              JOIN tblDEPARTMENT DE ON CO.CollegeID = DE.CollegeID
              JOIN tblCOURSE CS ON DE.DeptID = CS.DeptID
              JOIN tblCLASS CA ON CS.CourseID = CA.CourseID
              JOIN tblClass_List CL ON CA.ClassID = CL.ClassID
          WHERE CA.[YEAR] >= '2007'
          GROUP BY DE.DeptID, DE.DeptName, CO.CollegeID
          HAVING Count(Distinct CL.StudentID) > 10000) AS subq2 ON subq1.DeptID = Subq2.DeptID


/* 2.) Which Colleges have held at least 4 classes in buildings located on 'Stevens Way' in the
1980's that have also had fewer than 32,000 students make a 4.0 since 1990? */

SELECT CO.CollegeID, CO.CollegeName, FourPointZeroClub, COUNT(*) AS StevensWayClasses
FROM tblCollege CO
    JOIN tblDepartment DE ON CO.CollegeID = DE.CollegeID
    JOIN tblCOURSE CS ON DE.DeptID = CS.DeptID
    JOIN tblClass CA ON CS.CourseID = CA.CourseID
    JOIN tblClassroom CR ON CA.ClassroomID = CR.ClassroomID
    JOIN tblBuilding BD ON CR.BuildingID = BD.BuildingID
    JOIN tblLOCATION LO ON BD.LocationID = LO.LocationID
    JOIN (SELECT CO.CollegeID, CO.CollegeName, COUNT(DISTINCT CL.StudentID) AS FourPointZeroClub
          FROM tblCollege CO
              JOIN tblDepartment DE ON CO.CollegeID = DE.CollegeID
              JOIN tblCOURSE CS ON DE.DeptID = CS.DeptID
              JOIN tblClass CA ON CS.CourseID = CA.CourseID 
              JOIN tblClass_List CL ON CA.ClassID = CL.ClassID
          WHERE CL.Grade = 4.0
          AND CA.[YEAR] > '1989'
          GROUP BY CO.CollegeID, CO.CollegeName
          HAVING count(DISTINCT CL.StudentID) < 32000) AS subq1 ON CO.CollegeID = subq1.CollegeID
WHERE LO.LocationName = 'Stevens WAY'
AND CA.[YEAR] LIKE '198%'
GROUP BY CO.CollegeID, CO.CollegeName, FourPointZeroClub
HAVING COUNT(CA.ClassID) > = 4
ORDER BY CO.CollegeID ASC


/* 3.) Which students have taken more than one class in an auditorium and have also completed
fewer than 3 classes with a 3.9 or above? */

SELECT ST.StudentID, ST.StudentFname, ST.StudentLname, HighGrades, COUNT(*) AS AuditoriumClasses
FROM tblStudent ST
    JOIN tblCLASS_LIST CL ON ST.StudentID = CL.StudentID
    JOIN tblCLASS CA ON CL.ClassID = CA.ClassID
    JOIN tblCLASSROOM CR ON CA.ClassroomID = CR.ClassroomID
    JOIN tblCLASSROOM_Type CT ON CR.ClassroomTypeID = CT.ClassroomTypeID
    JOIN (SELECT ST.StudentID, ST.StudentFname, ST.StudentLname, COUNT(*) AS HighGrades
          FROM tblStudent ST
              JOIN tblCLASS_LIST CL ON ST.StudentID = CL.StudentID
          WHERE CL.GRADE >= 3.9
          GROUP BY ST.StudentID, ST.StudentFname, ST.StudentLname
          HAVING COUNT(*) < 3) AS subq1 ON ST.StudentID = subq1.StudentID
WHERE CT.ClassroomTypeName = 'Auditorium'
GROUP BY ST.StudentID, ST.StudentFname, ST.StudentLname, HighGrades
HAVING COUNT(*) > 1
ORDER BY St.StudentLname ASC


/* 4.) Write SQL query to determine the number of students who have received a grade of 3.5
or greater for a class from the College of Arts and Sciences since 1976. */

SELECT CO.CollegeID, CO.CollegeName, COUNT(DISTINCT ST.StudentID) AS ArtsAndSciences
FROM tblSTUDENT ST
    JOIN tblCLASS_LIST CL on ST.StudentID = CL.StudentID
    JOIN tblCLASS CA ON CL.ClassID = CA.ClassID
    JOIN tblCOURSE C ON CA.CourseID = C.CourseID
    JOIN tblDEPARTMENT DE ON C.DeptID = DE.DeptID
    JOIN tblCOLLEGE CO ON DE.CollegeID = CO.CollegeID
WHERE CL.Grade >= 3.5
AND CO.CollegeName = 'Arts and Sciences'
AND CA.[YEAR] >= '1976'
GROUP BY CO.CollegeID, CO.CollegeName


/* 5.) Write the SQL code to determine the 5 most popular courses by number of registrations
before 1986. */

SELECT TOP 5 WITH TIES CR.CourseName, COUNT(CL.StudentID) AS StudentRegistrations
FROM tblCLASS_LIST CL
    JOIN tblCLASS CA ON CL.ClassID = CA.ClassID
    JOIN tblCOURSE CR ON CA.CourseID = CR.CourseID
WHERE CA.[YEAR] < '1986'
GROUP BY CR.CourseName
ORDER BY StudentRegistrations DESC


/* 6.) Write the SQL code to determine which states have had at least 100 students who have
taken more than 2 classes from the Information School and have also completed more
than 3 classes from School of Medicine. */

SELECT ST.StudentPermState, COUNT(*) AS UWMed_iSchool
FROM tblSTUDENT ST
WHERE ST.StudentID IN (SELECT ST.StudentID
                      FROM tblSTUDENT ST
                            JOIN tblCLASS_LIST CL ON ST.StudentID = CL.StudentID
                            JOIN tblCLASS CA ON CL.ClassID = CA.ClassID
                            JOIN tblCOURSE C ON CA.CourseID = C.CourseID
                            JOIN tblDEPARTMENT DE ON C.DeptID = DE.DeptID
                            JOIN tblCOLLEGE CO ON DE.CollegeID = CO.CollegeID
                            JOIN (SELECT ST.StudentID, ST.StudentFname, ST.StudentLname, COUNT(*) AS Medicine
                                  FROM tblSTUDENT ST
                                      JOIN tblCLASS_LIST CL ON ST.StudentID = CL.StudentID
                                      JOIN tblCLASS CA ON CL.ClassID = CA.ClassID
                                      JOIN tblCOURSE C ON CA.CourseID = C.CourseID
                                      JOIN tblDEPARTMENT DE ON C.DeptID = DE.DeptID
                                      JOIN tblCOLLEGE CO ON DE.CollegeID = CO.CollegeID
                                  WHERE CO.CollegeName = 'Medicine'
                                  GROUP BY ST.StudentID, ST.StudentFname, ST.StudentLname
                                  HAVING COUNT(*) > 3) AS subq1 ON ST.StudentID = subq1.StudentID
                        WHERE CO.CollegeName = 'Information school'
                        GROUP BY ST.StudentID, ST.StudentFname, ST.StudentLname, Medicine
                        HAVING COUNT(*) > 2)
                        GROUP BY ST.StudentPermState
HAVING COUNT(*) >= 100
