WITH setPoint AS (
    SELECT
        *,
        CASE
            WHEN home_team_goals > away_team_goals THEN 3
            WHEN home_team_goals = away_team_goals THEN 1
            ELSE 0
        END AS home_team_point,
        CASE
            WHEN home_team_goals > away_team_goals THEN 0
            WHEN home_team_goals = away_team_goals THEN 1
            ELSE 3
        END AS away_team_point
    FROM
        Matches
),
homeSummary AS (
    SELECT
        t.team_name,
        count(*) AS matches_played,
        sum(home_team_point) AS points,
        sum(home_team_goals) AS goal_for,
        sum(away_team_goals) AS goal_against,
        sum(home_team_goals) - sum(away_team_goals) AS goal_diff
    FROM
        setPoint s
        INNER JOIN Teams t ON s.home_team_id = t.team_id
    GROUP BY
        t.team_name
),
awaySummary AS (
    SELECT
        t.team_name,
        count(*) AS matches_played,
        sum(away_team_point) AS points,
        sum(away_team_goals) AS goal_for,
        sum(home_team_goals) AS goal_against,
        sum(away_team_goals) - sum(home_team_goals) AS goal_diff
    FROM
        setPoint s
        INNER JOIN Teams t ON s.away_team_id = t.team_id
    GROUP BY
        t.team_name
)
SELECT
    team_name,
    sum(matches_played) AS matches_played,
    sum(points) AS points,
    sum(goal_for) AS goal_for,
    sum(goal_against) AS goal_against,
    sum(goal_diff) AS goal_diff
FROM
    (
        SELECT
            *
        FROM
            homeSummary
        UNION
        ALL
        SELECT
            *
        FROM
            awaySummary
    ) temp
GROUP BY
    team_name
ORDER BY
    sum(points) DESC,
    sum(goal_diff) DESC,
    team_name ASC
