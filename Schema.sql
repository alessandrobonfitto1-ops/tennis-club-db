CREATE TABLE PLAYER (
    IDcard CHAR(16) PRIMARY KEY,
    Street VARCHAR(64),
    City VARCHAR(64),
    CivicNumber VARCHAR(10),
    Gender CHAR(1) CHECK (Gender IN ('M', 'F')),
    Birthdate DATE,
    Telephone VARCHAR(20),
    Name VARCHAR(64) NOT NULL,
    Surname VARCHAR(64) NOT NULL
);
CREATE TABLE COURTS (
    CourtNumber INTEGER PRIMARY KEY,
    Surface VARCHAR(32),
    Cover VARCHAR(32)
);

CREATE TABLE TOURNAMENT (
    TournamentID INTEGER PRIMARY KEY,
    Name VARCHAR(64) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Type VARCHAR(32),
    LimitCategory VARCHAR(32),
    Prize VARCHAR(64)
);

CREATE TABLE DAY (
    Name VARCHAR(32) PRIMARY KEY,
    Time TIME,
    Duration INTEGER
);
CREATE TABLE INSTRUCTOR (
    IDcard CHAR(16) PRIMARY KEY,
    Certification VARCHAR(64),
    FOREIGN KEY (IDcard) REFERENCES PLAYER(IDcard)
);

CREATE TABLE COURSES (
    IDcourse INTEGER PRIMARY KEY,
    Instructor CHAR(16) NOT NULL,
    Level VARCHAR(32),
    FOREIGN KEY (Instructor) REFERENCES INSTRUCTOR(IDcard)
);

CREATE TABLE GROUPCOURSES (
    IDcourse INTEGER PRIMARY KEY,
    NumParticipants INTEGER,
    FOREIGN KEY (IDcourse) REFERENCES COURSES(IDcourse)
);

CREATE TABLE PRIVATECOURSES (
    IDcourse INTEGER PRIMARY KEY,
    HourlyRate INTEGER,
    FOREIGN KEY (IDcourse) REFERENCES COURSES(IDcourse)
);

CREATE TABLE ACADEMY (
    IDcourse INTEGER PRIMARY KEY,
    WeeklyHours INTEGER,
    FOREIGN KEY (IDcourse) REFERENCES COURSES(IDcourse)
);
CREATE TABLE MEMBER (
    IDcard CHAR(16) PRIMARY KEY,
    Courses INTEGER NOT NULL,
    RegistrationDate DATE,
    FOREIGN KEY (IDcard) REFERENCES PLAYER(IDcard),
    FOREIGN KEY (Courses) REFERENCES COURSES(IDcourse)
);

CREATE TABLE GUEST (
    IDcard CHAR(16) PRIMARY KEY,
    FOREIGN KEY (IDcard) REFERENCES PLAYER(IDcard)
);

CREATE TABLE BOOK (
    Player CHAR(16),
    Court INTEGER,
    Date DATE,
    StartTime TIME,
    EndTime TIME,
    Price INTEGER,
    PRIMARY KEY (Player, Court, Date, StartTime),
    FOREIGN KEY (Player) REFERENCES PLAYER(IDcard),
    FOREIGN KEY (Court) REFERENCES COURTS(CourtNumber)
);

CREATE TABLE PLACE (
    Course INTEGER,
    Court INTEGER,
    PRIMARY KEY (Course, Court),
    FOREIGN KEY (Course) REFERENCES COURSES(IDcourse),
    FOREIGN KEY (Court) REFERENCES COURTS(CourtNumber)
);

CREATE TABLE SCHEDULED (
    Course INTEGER,
    Day VARCHAR(32),
    PRIMARY KEY (Course, Day),
    FOREIGN KEY (Course) REFERENCES COURSES(IDcourse),
    FOREIGN KEY (Day) REFERENCES DAY(Name)
);
CREATE TABLE FEE (
    Code INTEGER PRIMARY KEY,
    Member CHAR(16) NOT NULL,
    Month INTEGER,
    Year INTEGER,
    Amount INTEGER,
    Type VARCHAR(32),
    Status VARCHAR(32),
    FOREIGN KEY (Member) REFERENCES MEMBER(IDcard)
);

CREATE TABLE PARTICIPATION (
    Player CHAR(16),
    Tournament INTEGER,
    PRIMARY KEY (Player, Tournament),
    FOREIGN KEY (Player) REFERENCES PLAYER(IDcard),
    FOREIGN KEY (Tournament) REFERENCES TOURNAMENT(TournamentID)
);

CREATE TABLE AMATEUR (
    TournamentID INTEGER PRIMARY KEY,
    SponsorName VARCHAR(64),
    FOREIGN KEY (TournamentID) REFERENCES TOURNAMENT(TournamentID)
);

CREATE TABLE FEDERAL (
    TournamentID INTEGER PRIMARY KEY,
    UmpireName VARCHAR(64),
    FOREIGN KEY (TournamentID) REFERENCES TOURNAMENT(TournamentID)
);
INSERT INTO PLAYER VALUES
('PLR0000000000001', 'Via Roma', 'Santa Lucia di Piave', '12', 'M', '1990-05-12', '3401234567', 'Marco', 'Rossi'),
('PLR0000000000002', 'Via Verdi', 'Conegliano', '5', 'F', '1995-08-23', '3409876543', 'Giulia', 'Bianchi'),
('PLR0000000000003', 'Via Mazzini', 'San Vendemiano', '20', 'M', '1988-02-15', '3475551234', 'Luca', 'Verdi'),
('PLR0000000000004', 'Via Garibaldi', 'Santa Lucia di Piave', '8', 'F', '2008-11-30', '3331112222', 'Sara', 'Neri');
INSERT INTO COURTS VALUES
(1, 'Clay', 'Covered'),
(2, 'Synthetic', 'Covered'),
(3, 'Synthetic', 'Not Covered');
INSERT INTO INSTRUCTOR VALUES
('PLR0000000000001', 'FIT Level 2 Coach');
INSERT INTO COURSES VALUES
(1, 'PLR0000000000001', 'Beginner'),
(2, 'PLR0000000000001', 'Youth');
INSERT INTO GROUPCOURSES VALUES
(1, 8);

INSERT INTO ACADEMY VALUES
(2, 6);
INSERT INTO MEMBER VALUES
('PLR0000000000002', 1, '2025-01-15'),
('PLR0000000000004', 2, '2025-09-10');

INSERT INTO GUEST VALUES
('PLR0000000000003');
INSERT INTO COURSES VALUES
(3, 'PLR0000000000001', 'Advanced');

INSERT INTO PRIVATECOURSES VALUES
(3, 40);
INSERT INTO BOOK VALUES
('PLR0000000000003', 1, '2026-06-20', '18:00', '19:00', 15),
('PLR0000000000002', 2, '2026-06-21', '10:00', '11:00', 12),
('PLR0000000000001', 3, '2026-06-22', '17:00', '18:30', 18);
INSERT INTO DAY VALUES
('Monday', '18:00', 90),
('Wednesday', '17:00', 60),
('Friday', '16:00', 60);

INSERT INTO SCHEDULED VALUES
(1, 'Monday'),
(2, 'Wednesday'),
(3, 'Friday');
INSERT INTO PLACE VALUES
(1, 1),
(2, 2),
(3, 1);
INSERT INTO FEE VALUES
(1, 'PLR0000000000002', 6, 2026, 50, 'Monthly', 'Paid'),
(2, 'PLR0000000000002', 7, 2026, 50, 'Monthly', 'Unpaid'),
(3, 'PLR0000000000004', 6, 2026, 40, 'Monthly', 'Paid');
INSERT INTO TOURNAMENT VALUES
(1, 'Spring Open', '2026-04-10', '2026-04-15', 'Single', 'Open', 'Trophy + 200 euro'),
(2, 'Summer Cup', '2026-07-01', '2026-07-05', 'Single', '4.3', 'Medal');
INSERT INTO AMATEUR VALUES
(1, 'Bar Sport Santa Lucia');

INSERT INTO FEDERAL VALUES
(2, 'Giovanni Marchetti');
INSERT INTO PARTICIPATION VALUES
('PLR0000000000001', 1),
('PLR0000000000002', 1),
('PLR0000000000003', 2),
('PLR0000000000002', 2);