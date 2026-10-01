/*
CREATE LOGIN NandaSurendra
WITH PASSWORD = 'MI$T353Instructor';

CREATE USER NandaSurendra
FOR LOGIN NandaSurendra;

ALTER ROLE db_owner ADD MEMBER NandaSurendra;
*/

if object_id('Stadium') is not null
    drop table stadium;
if object_id('Team') is not null
    drop table team;
if object_id('Game') is not null
    drop table game;

create table stadium (
    StadiumID INT NOT NULL IDENTITY(1,1),
    StadiumName VARCHAR(100) NOT NULL,
    StadiumCity VARCHAR(100) NOT NULL,
    StadiumState VARCHAR(100) NOT NULL,
    StadiumCapacity INT NOT NULL,
    TypeOfField VARCHAR(100) NOT NULL,
    GameID INT NOT NULL,
    constraint PK_Stadium PRIMARY KEY (StadiumID),
    constraint UQ_Stadium UNIQUE (StadiumName, StadiumCity, StadiumState),  
    constraint CK_Stadium_Capacity CHECK (TypeOfField IN ('Grass', 'Artificial Turf'))
);



Create table Team (
    TeamID INT NOT NULL IDENTITY(1,1),
    TeamName VARCHAR(100) NOT NULL,
    UniversityName VARCHAR(100) NOT NULL,
    StadiumID INT Not NULL,
    constraint PK_Team PRIMARY KEY (TeamID),
    constraint UQ_UniversityName UNIQUE (UniversityName)
);





CREATE table Game (
    GameID INT NOT NULL IDENTITY(1,1),
    GameDate Date NOT NULL,
    GameTime Time NOT NULL,
    HomeScore INT NULL,
    AwayScore INT NULL,
    HomeTeamID INT NOT NULL,
    AwayTeamID INT NOT NULL,
    WinnerTeamID INT NULL,
    StadiumID INT NOT NULL,
    constraint PK_Game PRIMARY KEY (GameID),
    constraint UQ_Game UNIQUE (HomeTeamID,GameDate, GameTime), 
    constraint FK_Game_HomeTeam FOREIGN KEY (HomeTeamID) REFERENCES Team(TeamID),
    constraint FK_Game_AwayTeam FOREIGN KEY (AwayTeamID) REFERENCES Team(TeamID),
    constraint FK_Game_WinnerTeam FOREIGN KEY (WinnerTeamID) REFERENCES Team(TeamID),
    constraint FK_Game_Stadium FOREIGN KEY (StadiumID) REFERENCES Stadium(StadiumID)
);


