---
title: Last Man Standing 2024
---

```sql pivot
select
  picks.week,
  picks.team,
  count(picks.*) as entries,
  odds.odds,
  CASE WHEN results.result = 'win' THEN 'survived' 
    WHEN results.result = 'loss' THEN 'eliminated'
    ELSE 'tbd' END
  AS chart_series,
  odds.ML,
  odds.spread
from survivor_picks.picks
left join survivor_picks.odds on CONCAT('WEEK ',odds.week) = picks.week and UPPER(odds.team) = UPPER(picks.team)
left join survivor_picks.results on odds.week = results.week and UPPER(odds.team) = UPPER(results.team)
group by all
order by entries desc
```

```sql total_entries
select
  sum(entries) as entries
from ${pivot}
```

```sql predicted_survivors
select week, team, entries, odds, entries*odds as predicted_survivors
from ${pivot}
```

```sql total_survivors
select sum(predicted_survivors) as total_predicted_survivors
from ${predicted_survivors}
```

# Total Entries

<BigValue 
  data={total_entries} 
  value=entries
/>

<BigValue 
  data={total_survivors} 
  value=total_predicted_survivors
/>

# Picks by Team

<BarChart 
    data={pivot}
    x=team
    y=entries 
    swapXY=true
    series=chart_series
    colorPalette={
        [
        '#EEEEEE',
        '#9ADE7B',
        '#FF8F8F'
        ]
    }
/>

# Picks Details

<DataTable data={pivot}> 
  <Column id=team/>
	<Column id=spread/> 
	<Column id=ML title=ML/> 
	<Column id=odds title='De-vigged Odds' fmt=pct1/> 
  <Column id=entries/> 
</DataTable>