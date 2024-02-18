USE BUDT703_Project_0506_12

--What is the ratio of game wins based on home, away, and neutral sites?
SELECT YEAR(p.calendarYear) as 'Year', p.playType AS 'Play Type',
	   ROUND(CAST(SUM(CASE WHEN playResult = 'W' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*), 2) AS WinRatio
FROM [Moneyball.Play] p
GROUP BY p.playType,YEAR(p.calendarYear)
ORDER BY YEAR(p.calendarYear);

--What is the team’s average margin of wins and losses in the previous years?
SELECT YEAR(calendarYear) as 'Year', 
      ROUND(AVG(CASE WHEN playresult = 'W' THEN CAST(playTerpScore - playOpponentScore AS FLOAT) ELSE NULL END),1) AS AvgWinMargin,
      ROUND(AVG(CASE WHEN playresult = 'L' THEN CAST(playTerpScore - playOpponentScore AS FLOAT) ELSE NULL END),1) AS AvgLossMargin 
FROM [Moneyball.Play]
GROUP BY YEAR(calendarYear)
ORDER BY YEAR(calendarYear);

-- What is the ratio of game wins in Big Ten conference games?

SELECT YEAR(p.calendarYear) as 'Year', 
	   ROUND(CAST(SUM(CASE WHEN playResult = 'W' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*), 2) AS WinRatio
FROM [Moneyball.Play] p, [Moneyball.Tournament] t
WHERE p.tournamentId = t.tournamentId AND t.tournamentName = 'Big Ten'
GROUP BY t.tournamentName, YEAR(p.calendarYear)
ORDER BY YEAR(p.calendarYear);

--What is the team’s Winning rate against opponents where atleast 10 games being played?
SELECT o.opponentName AS 'Oppononent Name',
	   ROUND(CAST(SUM(CASE WHEN p.playResult = 'W' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*), 2) AS WinRatio
FROM [Moneyball.Play] p
JOIN [Moneyball.Opponent] o ON p.opponentId = o.opponentId
GROUP BY p.opponentId, o.opponentName
HAVING COUNT(*)>=10
ORDER BY WinRatio DESC;


-- What is the win ratio over the years across different States? 
SELECT v.venueState AS 'State',
    ROUND(CAST(SUM(CASE WHEN p.playResult = 'W' THEN 1 ELSE 0 END) AS FLOAT) / COUNT(*), 2) AS WinRatio
FROM [Moneyball.Play] p, [Moneyball.Venue] v
WHERE p.venueId = v.venueId 
GROUP BY v.venueState
Order BY WinRatio DESC;


