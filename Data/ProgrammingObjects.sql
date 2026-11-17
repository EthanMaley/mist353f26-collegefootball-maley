-- 1. Action
go
create or alter procedure procGetAllTeamsByConference(
    @ConferenceName NVARCHAR(50) = null
)
as
begin
    select ConferenceName, UniversityName, TeamName
    from Conference C inner join Team T on T.ConferenceID = C.ConferenceID
    where ConferenceName = IsNull(@ConferenceName, ConferenceName );
end;

/*
    execute procGetAllTeamsByConference @ConferenceName = 'Big 12';
    execute procGetAllTeamsByConference;
*/

go

create or alter procedure procScheduleGame
(
    @homeTeamID int, @awayTeamID int, @gameDate date,
    @gameStartTime time, @stadiumID int, @gameID int output
)
as
begin
    insert into Game(HomeTeamId, AwayTeamId, GameDate,
        GameTime, StadiumId)
    values(@homeTeamID, @awayTeamID, @gameDate,
        @gameStartTime, @stadiumID);

    set @gameID = SCOPE_IDENTITY();
end;
/*
    declare @gameID int;
    execute procScheduleGame @homeTeamID = 1, @awayTeamID = 2,
        @gameDate = '2026-11-14', @gameStartTime = '19:00:00',
        @stadiumID = 1, @gameID = @gameID output;
    print @gameID;
*/

-- UpdateGameScores

