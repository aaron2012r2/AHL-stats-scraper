# AHL Daily Report Scraper
# Requires: tidyverse, rvest, stringr

library("tidyverse")
library("rvest")
library("stringr")

# The daily report is the same URL all season
url_dailyreport <- "http://admin.leaguestat.com/download.php?client_code=ahl&file_path=daily-report/daily-report.html"

# Function for retrieving specific table by number from xpath
# Input param tablenum: the number of the table from the xpath
# Default value 87 will retrieve Texas Stars skater stats
fnAhlTable <- function(tablenum = 87) {
  xpathnum = paste('/html/body/table[',as.character(tablenum),']', sep = "")
  return_list <- url_dailyreport %>%
    read_html() %>%
    html_nodes(xpath = xpathnum) %>%
    html_table()
  return_list
}

ListTables <- function() {
  all_h2 <- url_dailyreport %>% 
    read_html() %>% 
    html_nodes("h2") %>% 
    html_text()
  teams <- str_detect(all_h2, "^[A-Z].*\\W[A-Z].*\\WStatistics")
  all_teams <- trimws(unlist(str_extract_all(all_h2[teams], "^[A-Z].*\\W[A-Z].*\\W")))
  skater_tables <- seq(35,95,2)
  goalie_tables <- seq(36,96,2)
  dfTeams <- data.frame("Teams" = all_teams, "Skater Table" = skater_tables, "Goalie Table" = goalie_tables)
  print(dfTeams)
}
