with cte_pivot as (
SELECT 
    name,
    week,
    value as team
FROM raw_picks
UNPIVOT (
    value FOR week IN ("week 1", "week 2", "week 3", "week 4", "week 5", "week 6", "week 7", "week 8", "week 9", "week 10",
                       "week 11", "week 12", "week 13", "week 14", "week 15", "week 16", "week 17", "week 18")
))
select * from cte_pivot where week = 'WEEK 2'