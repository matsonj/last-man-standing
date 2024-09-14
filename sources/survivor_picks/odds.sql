select week, "City Name" as team, "De-Vigged Line" as odds, Spread as spread, Moneyline as ML,
from raw_odds
where week = 2