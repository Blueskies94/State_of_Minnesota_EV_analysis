SELECT TOP(10) [ZIP Code], [Vehicle Make], SUM(CONVERT(INT,[Vehicle Count])) as 'Vehicle Count'
from MN_EV_Registrations
group by [ZIP Code], [Vehicle Make]
having [ZIP Code] between '55001' and '56763'
order by SUM(CONVERT(INT,[Vehicle Count])) DESC

SELECT 
  M.[ZIP Code], MI.[Median income], MI.[Population],
  (SELECT
    SUM(CONVERT(INT,[Vehicle Count]))
    FROM MN_EV_Registrations as T
    WHERE T.[Vehicle Make] = 'TESLA'
      AND T.[zip code] = M.[zip code]
  ) AS TeslaCount,
  (SELECT
    SUM(CONVERT(INT,[Vehicle Count]))
    FROM MN_EV_Registrations as T
    WHERE T.[Vehicle Make] != 'TESLA'
      AND T.[zip code] = M.[zip code]
  ) AS NonTeslaCount
  FROM MN_EV_Registrations M
LEFT JOIN Minnesota_census_data MI
  ON MI.[ZIP Code] = M.[ZIP code]
GROUP BY M.[ZIP Code], MI.[ZIP code], MI.[Median income], MI.[Population]
HAVING M.[ZIP Code] between '55000' and '56763'
Order BY M.[ZIP Code] asc
