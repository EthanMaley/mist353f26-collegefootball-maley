
/*
CREATE LOGIN NandaSurendra
WITH PASSWORD = 'MI$T353Instructor';

CREATE USER NandaSurendra
FOR LOGIN NandaSurendra;

ALTER ROLE db_owner ADD MEMBER NandaSurendra;
*/



IF OBJECT_ID('WeeklyPredictionResults', 'U') IS NOT NULL
    DROP TABLE WeeklyPredictionResults;

IF OBJECT_ID('GamePredictions', 'U') IS NOT NULL
    DROP TABLE GamePredictions;

IF OBJECT_ID('ReturnerStats', 'U') IS NOT NULL
    DROP TABLE ReturnerStats;

IF OBJECT_ID('PunterStats', 'U') IS NOT NULL
    DROP TABLE PunterStats;

IF OBJECT_ID('KickerStats', 'U') IS NOT NULL
    DROP TABLE KickerStats;

IF OBJECT_ID('DefenderStats', 'U') IS NOT NULL
    DROP TABLE DefenderStats;

IF OBJECT_ID('RBStats', 'U') IS NOT NULL
    DROP TABLE RBStats;

IF OBJECT_ID('QBStats', 'U') IS NOT NULL
    DROP TABLE QBStats;

IF OBJECT_ID('PlayerStats', 'U') IS NOT NULL
    DROP TABLE PlayerStats;

IF OBJECT_ID('Position', 'U') IS NOT NULL
    DROP TABLE Position;

IF OBJECT_ID('Player', 'U') IS NOT NULL
    DROP TABLE Player;

IF OBJECT_ID('Roster', 'U') IS NOT NULL
    DROP TABLE Roster;

IF OBJECT_ID('AppUser', 'U') IS NOT NULL
    DROP TABLE AppUser;

IF OBJECT_ID('Game', 'U') IS NOT NULL
    DROP TABLE Game;

IF OBJECT_ID('Team', 'U') IS NOT NULL
    DROP TABLE Team;

IF OBJECT_ID('Stadium', 'U') IS NOT NULL
    DROP TABLE Stadium;

GO


CREATE TABLE Stadium (
    StadiumID INT NOT NULL IDENTITY(1,1),
    StadiumName VARCHAR(100) NOT NULL,
    StadiumCity VARCHAR(100) NOT NULL,
    StadiumState VARCHAR(100) NOT NULL,
    StadiumCapacity INT NOT NULL,
    TypeOfField VARCHAR(100) NOT NULL,
    GameID INT NOT NULL,

    CONSTRAINT PK_Stadium PRIMARY KEY (StadiumID),
    CONSTRAINT UQ_Stadium UNIQUE
        (StadiumName, StadiumCity, StadiumState),
    CONSTRAINT CK_Stadium_Capacity
        CHECK (TypeOfField IN ('Grass', 'Artificial Turf'))
);

GO



CREATE TABLE Team (
    TeamID INT NOT NULL IDENTITY(1,1),
    TeamName VARCHAR(100) NOT NULL,
    UniversityName VARCHAR(100) NOT NULL,
    StadiumID INT NOT NULL,

    CONSTRAINT PK_Team PRIMARY KEY (TeamID),
    CONSTRAINT UQ_UniversityName UNIQUE (UniversityName)
);

GO



CREATE TABLE Game (
    GameID INT NOT NULL IDENTITY(1,1),
    GameDate DATE NOT NULL,
    GameTime TIME NOT NULL,
    HomeScore INT NULL,
    AwayScore INT NULL,
    HomeTeamID INT NOT NULL,
    AwayTeamID INT NOT NULL,
    WinnerTeamID INT NULL,
    StadiumID INT NOT NULL,

    CONSTRAINT PK_Game PRIMARY KEY (GameID),
    CONSTRAINT UQ_Game UNIQUE
        (HomeTeamID, GameDate, GameTime),

    CONSTRAINT FK_Game_HomeTeam
        FOREIGN KEY (HomeTeamID)
        REFERENCES Team(TeamID),

    CONSTRAINT FK_Game_AwayTeam
        FOREIGN KEY (AwayTeamID)
        REFERENCES Team(TeamID),

    CONSTRAINT FK_Game_WinnerTeam
        FOREIGN KEY (WinnerTeamID)
        REFERENCES Team(TeamID),

    CONSTRAINT FK_Game_Stadium
        FOREIGN KEY (StadiumID)
        REFERENCES Stadium(StadiumID)
);

GO



CREATE TABLE AppUser (
    AppUserId INT IDENTITY(1,1) NOT NULL,
    AppUserName VARCHAR(100) NOT NULL,
    AppUserEmail VARCHAR(100) NOT NULL,
    AppUserPassword VARCHAR(100) NOT NULL,

    CONSTRAINT PK_AppUser PRIMARY KEY (AppUserId)
);

GO



CREATE TABLE Roster (
    RosterId INT IDENTITY(1,1) NOT NULL,
    TeamId INT NOT NULL,
    RosterYear INT NOT NULL,
    RosterWins INT NULL,
    RosterLosses INT NULL,
    RosterTies INT NULL,

    FOREIGN KEY (TeamId) REFERENCES Team(TeamId),
    CONSTRAINT PK_Roster PRIMARY KEY (RosterId)
);

GO


CREATE TABLE Player (
    PlayerId INT IDENTITY(1,1) NOT NULL,
    PlayerName CHAR(50) NOT NULL,
    PlayerPosition CHAR(20) NOT NULL,
    PlayerHeight VARCHAR(10) NOT NULL,
    PlayerWeight INT NOT NULL,
    PlayerDOB DATE NOT NULL,
    RosterId INT NOT NULL,

    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),
    CONSTRAINT PK_Player PRIMARY KEY (PlayerId)
);

GO



CREATE TABLE Position (
    PositionID INT NOT NULL IDENTITY(1,1),
    PositionName VARCHAR(50) NOT NULL,

    CONSTRAINT PK_Position PRIMARY KEY (PositionID),
    CONSTRAINT UQ_PositionName UNIQUE (PositionName)
);

GO



CREATE TABLE PlayerStats (
    PlayerStatsId INT IDENTITY(1,1) NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    PassingYards INT NULL,
    RushingYards INT NULL,
    ReceivingYards INT NULL,
    Touchdowns INT NULL,

    FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),

    CONSTRAINT PK_PlayerStats PRIMARY KEY (PlayerStatsId)
);

GO



CREATE TABLE QBStats (
    QBStatsId INT NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    PassingAttempts INT NULL,
    PassingCompletions INT NULL,
    PassingYards INT NULL,
    PassingTouchdowns INT NULL,
    Interceptions INT NOT NULL DEFAULT 0,

    CONSTRAINT PK_QBStats PRIMARY KEY (QBStatsId),

    CONSTRAINT FK_QBStats_PlayerStats
        FOREIGN KEY (QBStatsId)
        REFERENCES PlayerStats(PlayerStatsId)
);

GO



CREATE TABLE RBStats (
    RBStatsId INT IDENTITY(1,1) NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    RushingAttempts INT NULL,
    RushingYards INT NULL,
    RushingTouchdowns INT NULL,
    LongestRush INT NULL,
    Fumbles INT NULL,

    FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),

    CONSTRAINT PK_RBStats PRIMARY KEY (RBStatsId)
);

GO



CREATE TABLE DefenderStats (
    DefenderStatsId INT IDENTITY(1,1) NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    Tackles INT NULL,
    Sacks INT NULL,
    Interceptions INT NULL,
    ForcedFumbles INT NULL,
    DefensiveTouchdowns INT NULL,

    FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),

    CONSTRAINT PK_DefenderStats PRIMARY KEY (DefenderStatsId)
);

GO



CREATE TABLE KickerStats (
    KickerStatsId INT IDENTITY(1,1) NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    FieldGoalsMade INT NULL,
    FieldGoalsAttempted INT NULL,
    ExtraPointsMade INT NULL,
    ExtraPointsAttempted INT NULL,
    LongestFieldGoal INT NULL,

    FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),

    CONSTRAINT PK_KickerStats PRIMARY KEY (KickerStatsId)
);

GO



CREATE TABLE PunterStats (
    PunterStatsId INT IDENTITY(1,1) NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    Punts INT NULL,
    PuntYards INT NULL,
    LongestPunt INT NULL,

    FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),

    CONSTRAINT PK_PunterStats PRIMARY KEY (PunterStatsId)
);

GO



CREATE TABLE ReturnerStats (
    ReturnerStatsId INT IDENTITY(1,1) NOT NULL,
    PlayerId INT NOT NULL,
    RosterId INT NOT NULL,
    KickReturns INT NULL,
    KickReturnYards INT NULL,
    KickReturnLong INT NULL,
    KickReturnTouchdowns INT NULL,
    PuntReturns INT NULL,
    PuntReturnYards INT NULL,
    PuntReturnTouchdowns INT NULL,
    PuntReturnLong INT NULL,

    FOREIGN KEY (PlayerId) REFERENCES Player(PlayerId),
    FOREIGN KEY (RosterId) REFERENCES Roster(RosterId),

    CONSTRAINT PK_ReturnerStats PRIMARY KEY (ReturnerStatsId)
);

GO



CREATE TABLE GamePredictions (
    GamePredictionsId INT IDENTITY(1,1) NOT NULL,
    GameId INT NOT NULL,
    PredictedWinnerTeamId INT NULL,
    PredictedScore INT NULL,

    FOREIGN KEY (GameId) REFERENCES Game(GameId),
    FOREIGN KEY (PredictedWinnerTeamId) REFERENCES Team(TeamId),

    CONSTRAINT PK_GamePredictions
        PRIMARY KEY (GamePredictionsId)
);

GO



CREATE TABLE WeeklyPredictionResults (
    WeeklyPredictionResultsId INT IDENTITY(1,1) NOT NULL,
    GameId INT NOT NULL,
    PredictedWinnerTeamId INT NULL,
    PredictedScore INT NULL,
    ActualWinnerTeamId INT NULL,
    ActualScore INT NULL,

    FOREIGN KEY (GameId) REFERENCES Game(GameId),
    FOREIGN KEY (PredictedWinnerTeamId) REFERENCES Team(TeamId),
    FOREIGN KEY (ActualWinnerTeamId) REFERENCES Team(TeamId),

    CONSTRAINT PK_WeeklyPredictionResults
        PRIMARY KEY (WeeklyPredictionResultsId)
);

GO
