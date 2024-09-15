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
    WHEN results.result = 'loss' OR picks.team = 'NO PICK' THEN 'eliminated'
    ELSE 'tbd' END
  AS chart_series,
  odds.ML,
  odds.spread
from survivor_picks.picks
left join survivor_picks.odds on CONCAT('WEEK ',odds.week::int) = picks.week and UPPER(odds.team) = UPPER(picks.team)
left join survivor_picks.results on odds.week = results.week and UPPER(odds.team) = UPPER(results.team)
group by all
order by chart_series, entries desc
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

```sql upset_picks
select sum(entries) as upset_picks
from ${pivot}
where odds < 0.5
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

<BigValue 
  data={upset_picks} 
  value=upset_picks
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
	      '#FF8F8F',
        '#9ADE7B',
        '#EEEEEE'
        ]
    }
/>

# Picks Details

<DataTable data={pivot}> 
  <Column id=team/>
	<Column id=spread/> 
	<Column id=ML title=ML/> 
	<Column id=odds title='De-vigged Odds' fmt=pct1/> 
  <Column id=entries title='Picks'/> 
</DataTable>

_NFL game lines sourced from https://www.vegasinsider.com/nfl_
