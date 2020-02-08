# AHL Daily Report Scraper
# Requires: Tidyverse, Rvest

library("tidyverse")
library("rvest")

# The daily report is the same URL all season
url_dailyreport <- "http://admin.leaguestat.com/download.php?client_code=ahl&file_path=daily-report/daily-report.html"

# Function for retrieving specific table by number from xpath
# Input param tablenum: the number of the table from the xpath
# Default value 87 will retrieve Texas Stars skater stats
fnAhlTable <- function(tablenum = 87) {
  xpathnum = paste('/html/body/table[',as.character(tablenum),']', sep = "")
  return_list <- url %>%
    read_html() %>%
    html_nodes(xpath = xpathnum) %>%
    html_table()
}

