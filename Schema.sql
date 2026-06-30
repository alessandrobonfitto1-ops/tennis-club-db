

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
