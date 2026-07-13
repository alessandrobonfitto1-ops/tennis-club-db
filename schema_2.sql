-- ===================================================================
-- Tennis Club Database - Schema (DDL)
-- ===================================================================

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
    IDTournament INTEGER PRIMARY KEY,
    Name VARCHAR(64) NOT NULL,
    StartDate DATE,
    EndDate DATE,
    Type VARCHAR(32),
    LimitCategory VARCHAR(32),
    Prize VARCHAR(64)
);

CREATE TABLE DAY (
    Name VARCHAR(32) PRIMARY KEY
);

CREATE TABLE INSTRUCTOR (
    IDCard CHAR(16) PRIMARY KEY,
    Certification VARCHAR(64),
    FOREIGN KEY (IDCard) REFERENCES PLAYER(IDcard)
);

CREATE TABLE COURSES (
    IDCourse INTEGER PRIMARY KEY,
    Instructor CHAR(16) NOT NULL,
    Level VARCHAR(32),
    FOREIGN KEY (Instructor) REFERENCES INSTRUCTOR(IDCard)
);

CREATE TABLE GROUPCOURSES (
    IDCourse INTEGER PRIMARY KEY,
    NumParticipants INTEGER,
    FOREIGN KEY (IDCourse) REFERENCES COURSES(IDCourse)
);

CREATE TABLE PRIVATECOURSES (
    IDCourse INTEGER PRIMARY KEY,
    HourlyRate INTEGER,
    FOREIGN KEY (IDCourse) REFERENCES COURSES(IDCourse)
);

CREATE TABLE ACADEMY (
    IDCourse INTEGER PRIMARY KEY,
    WeeklyHours INTEGER,
    FOREIGN KEY (IDCourse) REFERENCES COURSES(IDCourse)
);

CREATE TABLE MEMBER (
    IDcard CHAR(16) PRIMARY KEY,
    Course INTEGER NOT NULL,
    RegistrationDate DATE,
    FOREIGN KEY (IDcard) REFERENCES PLAYER(IDcard),
    FOREIGN KEY (Course) REFERENCES COURSES(IDCourse)
);

CREATE TABLE GUEST (
    IDcard CHAR(16) PRIMARY KEY,
    VisitDate DATE,
    FOREIGN KEY (IDcard) REFERENCES PLAYER(IDcard)
);

-- Booking is now its own entity (Code, Date, StartTime, EndTime, Price),
-- linked to exactly one player (RESERVATION) and one court (REFERSTO).
CREATE TABLE BOOK (
    Code INTEGER PRIMARY KEY,
    Date DATE,
    StartTime TIME,
    EndTime TIME,
    Price INTEGER
);

-- Assumption: one booking has exactly one player -> UNIQUE(Book)
CREATE TABLE RESERVATION (
    Book INTEGER,
    Player CHAR(16) NOT NULL,
    PRIMARY KEY (Book, Player),
    UNIQUE (Book),
    FOREIGN KEY (Book) REFERENCES BOOK(Code),
    FOREIGN KEY (Player) REFERENCES PLAYER(IDcard)
);

-- Assumption: one booking has exactly one court -> UNIQUE(Book)
CREATE TABLE REFERSTO (
    Book INTEGER,
    Courts INTEGER NOT NULL,
    PRIMARY KEY (Book, Courts),
    UNIQUE (Book),
    FOREIGN KEY (Book) REFERENCES BOOK(Code),
    FOREIGN KEY (Courts) REFERENCES COURTS(CourtNumber)
);

CREATE TABLE PLACE (
    Course INTEGER,
    Court INTEGER,
    PRIMARY KEY (Course, Court),
    FOREIGN KEY (Course) REFERENCES COURSES(IDCourse),
    FOREIGN KEY (Court) REFERENCES COURTS(CourtNumber)
);

CREATE TABLE SCHEDULED (
    Course INTEGER,
    Day VARCHAR(32),
    Time TIME,
    Duration INTEGER,  -- minutes
    PRIMARY KEY (Course, Day),
    FOREIGN KEY (Course) REFERENCES COURSES(IDCourse),
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
    FOREIGN KEY (Tournament) REFERENCES TOURNAMENT(IDTournament)
);

CREATE TABLE AMATEURTOURNAMENT (
    IDTournament INTEGER PRIMARY KEY,
    SponsorName VARCHAR(64),
    FOREIGN KEY (IDTournament) REFERENCES TOURNAMENT(IDTournament)
);

CREATE TABLE FEDERALTOURNAMENT (
    IDTournament INTEGER PRIMARY KEY,
    UmpireName VARCHAR(64),
    FOREIGN KEY (IDTournament) REFERENCES TOURNAMENT(IDTournament)
);
