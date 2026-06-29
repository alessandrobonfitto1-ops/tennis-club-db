-- change column type
ALTER TABLE player 
    ALTER COLUMN city TYPE varchar(64);
-- change column name
ALTER TABLE player 
    RENAME COLUMN city TO city;
-- Change column comment
COMMENT ON COLUMN player.city IS 'comment';

SELECT P.Name, P.Surname, F.Month, F.Year
FROM PLAYER AS P
    JOIN MEMBER AS M ON P.IDcard = M.IDcard
    JOIN FEE AS F ON M.IDcard = F.Member
WHERE F.Status = 'Unpaid';

SELECT C.CourtNumber, C.Surface, COUNT(*) AS NumBookings
FROM COURTS AS C
    JOIN BOOK AS B ON C.CourtNumber = B.Court
GROUP BY C.CourtNumber, C.Surface
ORDER BY NumBookings DESC;
SELECT T.Name, T.StartDate, COUNT(*) AS NumParticipants
FROM TOURNAMENT AS T
    JOIN PARTICIPATION AS P ON T.TournamentID = P.Tournament
GROUP BY T.TournamentID, T.Name, T.StartDate
ORDER BY NumParticipants DESC;
SELECT P.Name, P.Surname
FROM PLAYER AS P
WHERE P.IDcard NOT IN (SELECT Player FROM BOOK);
SELECT C.CourtNumber, C.Surface, COUNT(*) AS NumBookings
FROM COURTS AS C
    JOIN BOOK AS B ON C.CourtNumber = B.Court
GROUP BY C.CourtNumber, C.Surface
HAVING COUNT(*) >= ALL (SELECT COUNT(*)
                        FROM BOOK
                        GROUP BY Court);

SELECT CO.IDcourse, CO.Level, P.Name, P.Surname
FROM COURSES AS CO
    JOIN INSTRUCTOR AS I ON CO.Instructor = I.IDcard
    JOIN PLAYER AS P ON I.IDcard = P.IDcard;
SELECT C.CourtNumber, C.Surface, SUM(B.Price) AS TotalRevenue
FROM COURTS AS C
    JOIN BOOK AS B ON C.CourtNumber = B.Court
GROUP BY C.CourtNumber, C.Surface;

SELECT P.Name, P.Surname, M.RegistrationDate
FROM PLAYER AS P
    JOIN MEMBER AS M ON P.IDcard = M.IDcard
WHERE M.RegistrationDate >= '2025-01-01';

SELECT CO.IDcourse, CO.Level, S.Day, D.Time
FROM COURSES AS CO
    JOIN SCHEDULED AS S ON CO.IDcourse = S.Course
    JOIN DAY AS D ON S.Day = D.Name;

SELECT P.Name, P.Surname, SUM(F.Amount) AS TotalPaid
FROM PLAYER AS P
    JOIN MEMBER AS M ON P.IDcard = M.IDcard
    JOIN FEE AS F ON M.IDcard = F.Member
WHERE F.Status = 'Paid'
GROUP BY P.IDcard, P.Name, P.Surname;
                        