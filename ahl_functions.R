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
fnAhlTable <- function(tablenum = 87, cleanSkaters = TRUE) {
  xpathnum = paste('/html/body/table[',as.character(tablenum),']', sep = "")
  table_return <- url_dailyreport %>%
    read_html() %>%
    html_nodes(xpath = xpathnum) %>%
    html_table()
  df_Table <- table_return[[1]]
  
  if (cleanSkaters == TRUE) {
  # Consolidate multiple teams onto only total line
  df_Table <- df_Table %>%
    filter(No. != "NA") %>%
    # Remove goalies and total
    filter(POS != "G")
  # Add designation for Rookie
  df_Table$Rookie <- str_detect(df_Table$PLAYER, "\\*")
  # Add designation for Active
  df_Table$Active <- !str_detect(df_Table$PLAYER, "^(x )|^(\\*x )")
  # Clean names
  df_Table$PLAYER <- str_replace_all(df_Table$PLAYER, "^(x )|^(\\*x )|^\\* |\\(total\\)$", "")
  } else {}
  df_Table
  
}



# ListTables: none

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
  dfTeams
}



# fnAllTeams: cleanSkaters

fnAllTeams <- function(cleanSkaters = TRUE){
  
  alltables <- ListTables()
  
  # Seed first set in data frame for all teams
  dfAllTeams <- fnAhlTable(alltables[1,2], cleanSkaters = cleanSkaters)
  dfAllTeams$TEAM <- rep(as.character(alltables[1,]$Teams),nrow(dfAllTeams))
  
  # Populate with remaining teams
  for (team in 2:nrow(alltables)) {
    tempRow <- alltables[team,]
    tempTeam <- fnAhlTable(tempRow[2], cleanSkaters = cleanSkaters)
    tempTeam$TEAM <- rep(as.character(tempRow$Teams),nrow(tempTeam))
    dfAllTeams <- rbind(dfAllTeams, tempTeam)
  }
  
  # Return the full data frame
  dfAllTeams
  
  }
