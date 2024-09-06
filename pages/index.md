---
title: Last Man Standing 2024
---

```sql pivot
select
  picks.week,
  picks.team,
  count(picks.*) as entries,
  odds.odds
from survivor_picks.picks
left join survivor_picks.odds on CONCAT('WEEK ',odds.week) = picks.week and UPPER(odds.team) = UPPER(picks.team)
group by all
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
/>