# AHL stats scraper
A simple table scraper from the AHL daily reports page written for R programmers
 
This is a work in progress. Please use the Issues tab to call out specific needs.

Upcoming features: Remove hard-coded references, clean and consolidate tables that include skaters' multiple teams, team-based data frames for skaters and goalies, league-level scraping, data visualizations

## Getting Started
Running this R script will load the required packages and create a set of functions for scraping the AHL daily reports page. There is no barrier to entry, provided you have all prerequisites installed.

### Prerequisites
You should have tidyverse and rvest installed
```
install.packages("tidyverse")
install.packages("rvest")
```

## Example
Download Texas Stars skater data, then see Tanner Kero's stats
```
> txSkaters <- fnAhlTable(87)
> txSkaters[[1]][txSkaters[[1]]$PLAYER == "Tanner Kero",]

  No.      PLAYER POS GP G  A PTS +/- PIM PP PPA SHG SHA GW FG IG OT UA EN SOG SOA SGW  SO% SH  SH%
4  20 Tanner Kero   C 34 7 19  26  -9  16  2   8   0   0  0  2  1  0  1  1   2   7   2 28.6 68 10.3
```

## Acknowledgements
The Hockey Analytics community is extensive, but of particular note, these people have encouraged the creation and dialogue around more open and advanced analytics in hockey

* **Alison Lukan** - [Twitter](https://twitter.com/alisonl) / [The Athletic](https://theathletic.com/author/alison-lukan/)

* **Evolving Wild** - [GitHub](https://github.com/evolvingwild) / [Website](https://evolving-hockey.com/)

* **Micah Blake McCurdy** - [Website](https://hockeyviz.com/) / [Twitter](https://twitter.com/IneffectiveMath)




