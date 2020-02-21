# AHL stats scraper
A simple table scraper from the AHL daily reports page written for R programmers
 
This is a work in progress. Please use the Issues tab to call out specific needs.

Upcoming features: Remove hard-coded references, team-based data frames for skaters and goalies, league-level scraping, data visualizations

## Getting Started
Running this R script will load the required packages and create a set of functions for scraping the AHL daily reports page. There is no barrier to entry, provided you have all prerequisites installed.

### Prerequisites
You should have tidyverse, rvest, and stringr installed
```
install.packages("tidyverse")
install.packages("rvest")
install.packages("stringr")
```

## Functions
**ListTables** will show all teams and the index of their table. It takes no arguments.
```
> ListTables()
```


**fnAhlTable** is the core function for downloading tables. It takes two arguments: the table number (as _tablenum_ defaulting to 87 for the Texas Stars skaters), and whether it should clean it as a skater table (as _cleanSkaters_ defaulting to TRUE)

Example: Download Texas Stars skater data, then see Tanner Kero's stats
```
> txSkaters <- fnAhlTable(tablenum = 87, cleanSkaters = TRUE)
> txSkaters[txSkaters$PLAYER == "Tanner Kero",]

  No.      PLAYER POS GP G  A PTS +/- PIM PP PPA SHG SHA GW FG IG OT UA EN SOG SOA SGW SO% SH SH% Rookie Active
4  20 Tanner Kero   C 39 7 21  28 -11  18  2   9   0   0  0  2  1  0  1  1   2   8   2  25 84 8.3  FALSE   TRUE
```

**fnAllTeams** is a function for gathering all team skaters into one data frame. It takes one argument, whether to clean the skater table or not (as _cleanSkaters_, to pass directly to fnAhlTable)

Example: Download all teams data, then see the top 5 rows
```
> allSkaters <- fnAllTeams(cleanSkaters = TRUE)
> head(allSkaters, 5)
  No.          PLAYER POS GP  G  A PTS +/- PIM PP PPA SHG SHA GW FG IG OT UA EN SOG SOA SGW  SO%  SH  SH% Rookie Active                TEAM
1  18     Josh Currie  RW 50 22 17  39   3  54  9   4   0   0  2  7  1  0  0  0   1   2   0 50.0 177 12.4  FALSE   TRUE Bakersfield Condors
2  16    Tyler Benson   F 43  9 27  36  -8  34  3  14   0   0  1  2  1  0  1  1   1   3   0 33.3  99  9.1  FALSE  FALSE Bakersfield Condors
3   2   Evan Bouchard   D 50  7 26  33  -9  32  4  11   0   2  1  1  2  0  0  0   0   1   0  0.0 127  5.5   TRUE  FALSE Bakersfield Condors
4  17     Brad Malone   C 49 13 18  31 -13  88  6   4   1   0  1  2  1  1  1  1   0   0   0  0.0  70 18.6  FALSE   TRUE Bakersfield Condors
5   5 Joe Gambardella  LW 44 12 14  26 -16  11  0   3   0   0  0  3  0  0  1  0   0   1   0  0.0  82 14.6  FALSE   TRUE Bakersfield Condors
```


## Acknowledgements
The Hockey Analytics community is extensive, but of particular note, these people have encouraged the creation and dialogue around more open and advanced analytics in hockey

* **Alison Lukan** - [Twitter](https://twitter.com/alisonl) / [The Athletic](https://theathletic.com/author/alison-lukan/)

* **Evolving Wild** - [GitHub](https://github.com/evolvingwild) / [Website](https://evolving-hockey.com/)

* **Micah Blake McCurdy** - [Website](https://hockeyviz.com/) / [Twitter](https://twitter.com/IneffectiveMath)




