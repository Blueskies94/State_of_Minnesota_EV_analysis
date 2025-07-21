/* SELECT TOP(10)
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
Order BY M.[ZIP Code] asc */

/* This query fetches the first 10 rows grouped by ZIP Code from the MN_EV_Registrations table, aliased as M.
Since we are LEFT JOINING the Minnesota_census_data table, aliased as MI, we exclude ZIP codes from the census that do not have a registered EV.
Using two correlated subqueries that give us the Sum of Tesla EVs and Non Tesla EVs by ZIP code, we have below a sample of Electric Vehicle data
according to each ZIP Code in the State of Minnesota, joined with Median income and Population from the Census dataset corresponding to each ZIP. */



| ZIP Code | Median income | Population | TeslaCount | NonTeslaCount |
|----------|---------------|------------|------------|---------------|
| 55001    | 130625        | 2995       | 34         | 84            |
| 55003    | 115781        | 4024       | 15         | 36            |
| 55005    | 109464        | 4927       | 10         | 25            |
| 55006    | 64167         | 3883       | 4          | 9             |
| 55007    | 66875         | 2272       | NULL       | 5             |
| 55008    | 83209         | 16514      | 31         | 83            |
| 55009    | 89023         | 8252       | 11         | 36            |
| 55011    | 126957        | 10517      | 29         | 50            |
| 55012    | 93500         | 1948       | 6          | 9             |
| 55013    | 99898         | 6985       | 23         | 46            |

/* This data was copied with headers into an Excel workbook. From there, three additional columsn were added:
1. Total_EVs- The sum of TeslaCount and NonTeslaCount
2. Tesla_Proportion_of_Evs- Divides values in the TeslaCount column with those in the Total_EVs column.
3. EV_per_1k_people- Divdes values in the Total_EVs with those in the population column.

The Excel worksheet containing the data was saved as a .csv file, later to be used in Python for regression analysis.
*/

  
/* SELECT [Vehicle Make], SUM(CONVERT(INT,[Vehicle Count])) as 'Vehicle Count'
from MN_EV_Registrations
where [ZIP Code] >= '55001' and [ZIP Code] <= '56763'
group by [Vehicle Make]
order by SUM(CONVERT(INT,[Vehicle Count])) DESC */

/* This query gives us the most common Vehicle Makes of Electric Vehicles and is useful for referencing to clue us into any correlation between
the proportion of Teslas out of all EVs and the Median Income for each ZIP Code. */

| Vehicle Make         | Vehicle Count |
|----------------------|---------------|
| TESLA                | 25213         |
| CHEVROLET            | 7316          |
| FORD                 | 5043          |
| JEEP                 | 3775          |
| HYUNDAI              | 3217          |
| VOLVO                | 3209          |
| NISSAN               | 3103          |
| BMW                  | 2950          |
| TOYOTA               | 2792          |
| VOLKSWAGEN           | 2049          |
| KIA                  | 1934          |
| CHRYSLER             | 1829          |
| AUDI                 | 1745          |
| MITSUBISHI           | 1545          |
| RIVIAN               | 1506          |
| MAZDA                | 791           |
| POLESTAR             | 723           |
| HONDA                | 669           |
| MERCEDES-BENZ        | 623           |
| PORSCHE              | 448           |
| ...                  | ...           |
