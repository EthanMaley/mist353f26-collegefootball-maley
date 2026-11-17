if __package__:
    from .get_db_connection import get_db_connection
else:
    from get_db_connection import get_db_connection


def get_all_teams_by_conference(conference: str):
    with get_db_connection() as connection:
        with connection.cursor(as_dict=True) as cursor:
            cursor.execute(
                "EXEC dbo.procGetAllTeamsByConference @ConferenceName = %s",
                (conference,),
            )
            return cursor.fetchall()
