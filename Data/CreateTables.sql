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
if object_id('AppUser', 'U') is not null drop table AppUser;
if object_id('Roster', 'U') is not null drop table Roster;
if object_id('Player', 'U') is not null drop table Player;
if object_id('PlayerStats', 'U') is not null drop table PlayerStats;
if object_id('QBStats', 'U') is not null drop table QBStats;
if object_id('RBStats', 'U') is not null drop table RBStats;
if object_id('DefenderStats', 'U') is not null drop table DefenderStats;
if object_id('KickerStats', 'U') is not null drop table KickerStats;
if object_id('PunterStats', 'U') is not null drop table PunterStats
if object_id('ReturnerStats', 'U') is not null drop table ReturnerStats;
go



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

go
create table Roster(
    RosterId int identity(1,1) not null,
    TeamId int not null,
    RosterYear int not null,
    RosterWins int null,
    RosterLosses int null,
    RosterTies int null,
    foreign key (TeamId) references Team(TeamId),
    constraint PK_Roster primary key (RosterId),
);
go
create table Player(
    PlayerId int identity(1,1) not null,
    PlayerName char(50) not null,
    PlayerPosition char(20) not null,
    PlayerHeight varchar(10) not null,
    PlayerWeight int not null,
    PlayerDOB date not null,
    RosterId int not null,
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_Player primary key (PlayerId),
);
go
create table PlayerStats(
    PlayerStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    PassingYards int null,
    RushingYards int null,
    ReceivingYards int null,
    Touchdowns int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_PlayerStats primary key (PlayerStatsId),
);
go
create table QBStats(
    QBStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    PassingAttempts int null,
    PassingCompletions int null,
    PassingYards int null,
    PassingTouchdowns int null,
    Interceptions int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_QBStats primary key (QBStatsId),
);
go
create table RBStats(
    RBStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    RushingAttempts int null,
    RushingYards int null,
    RushingTouchdowns int null,
    LongestRush int null,
    Fumbles int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_RBStats primary key (RBStatsId),
);
go
create table DefenderStats(
    DefenderStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    Tackles int null,
    Sacks int null,
    Interceptions int null,
    ForcedFumbles int null,
    DefensiveTouchdowns int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_DefenderStats primary key (DefenderStatsId),
);
GO
create table KickerStats(
    KickerStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    FieldGoalsMade int null,
    FieldGoalsAttempted int null,
    ExtraPointsMade int null,
    ExtraPointsAttempted int null,
    LongestFieldGoal int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_KickerStats primary key (KickerStatsId),
);
GO
create table PunterStats(
    PunterStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    Punts int null,
    PuntYards int null,
    LongestPunt int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_PunterStats primary key (PunterStatsId),
);
GO
create table ReturnerStats(
    ReturnerStatsId int identity(1,1) not null,
    PlayerId int not null,
    RosterId int not null,
    KickReturns int null,
    KickReturnYards int null,
    KickReturnLong int null,
    KickReturnTouchdowns int null,
    PuntReturns int null,
    PuntReturnYards int null,
    PuntReturnTouchdowns int null,
    PuntReturnLong int null,
    foreign key (PlayerId) references Player(PlayerId),
    foreign key (RosterId) references Roster(RosterId),
    constraint PK_ReturnerStats primary key (ReturnerStatsId),
);

