-- 1. Action
go
create or alter procedure procGetAllTeamsInAConference(
    @ConferenceName NVARCHAR(50)
)
as
begin
    select UniversityName, TeamName
    from Conference C inner join Team T on T.ConferenceID = C.ConferenceID
    where ConferenceName = @ConferenceName;
end;


-- execute procGetAllTeamsInAConference @ConferenceName = 'Big 12';
go

create or alter procedure procGetAllTeamsInAConference(
    @ConferenceName NVARCHAR(50) = null
)
as
begin
    select ConferenceName, UniversityName, TeamName
    from Conference C inner join Team T on T.ConferenceID = C.ConferenceID
    where ConferenceName = IsNull(@ConferenceName, ConferenceName );
end;

-- UpdateGameScores

