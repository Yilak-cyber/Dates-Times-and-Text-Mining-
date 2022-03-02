# Dates and Times

#..........................................................................#

# Key points

# Dates are a separate data type in R.The tidyverse includes functionality for 
 # dealing with dates through the lubridate package. 
# Extract the year, month and day from a date object with the year(), month()
 # and day() functions.
# Parsers convert strings into dates with the standard YYYY-MM-DD format 
 # (ISO 8601 format). Use the parser with the name corresponding to the string 
 # format of year, month and day (ymd(), ydm(), myd(), mdy(), dmy(), dym()).
# Get the current time with the Sys.time() function. Use the now() function 
 # instead to specify a time zone.
# You can extract values from time objects with the hour(), minute() and 
 # second() functions.
# Parsers convert strings into times (for example, hms()). Parsers can also 
 # create combined date-time objects (for example, mdy_hms()).
# inspect the startdate column of 2016 polls data, a Date type

#..........................................................................#

library(tidyverse)
library(dslabs)
data("polls_us_election_2016")

str(polls_us_election_2016)

polls_us_election_2016$startdate %>% head
class(polls_us_election_2016$startdate)
as.numeric(polls_us_election_2016$startdate) %>% head
library(lubridate)

# ggplot is aware of dates
polls_us_election_2016 %>% filter(pollster == "Ipsos" & state =="U.S.") %>%
  ggplot(aes(startdate, rawpoll_trump)) +
  geom_line()

# lubridate: the tidyverse date package

# select some random dates from polls
set.seed(2)
dates <- sample(polls_us_election_2016$startdate, 10) %>% sort
dates

polls_us_election_2016$startdate
# extract month, day, year from date strings
df<-data.frame(date = dates, 
           month = month(dates),
           day = day(dates),
           year = year(dates))
month(polls_us_election_2016$startdate,label = TRUE)
month(dates, label = TRUE)    # extract month label


# ymd works on mixed date styles
x <- c(20090101, "2009-01-02", "2009 01 03", "2009-1-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07")

y <- c(20090101, "2009-Jun-02", "2009 01 03", "2009-January-4",
       "2009-1, 5", "Created on 2009 1 6", "200901 !!! 07")
ymd(x)
ymd(y)
# different parsers extract year, month and day in different orders
x <- "09/01/02"
ymd(x)
mdy(x)
ydm(x)
myd(x)
dmy(x)
dym(x)

Sys.time()

now()    # current time in your time zone
now("GMT")    # current time in GMT
now() %>% hour()    # current hour
now() %>% minute()    # current minute
now() %>% second()    # current second

# parse time
x <- c("12:34:56")
hms(x)

#parse datetime
x <- "Nov/2/2012 12:34:56"
mdy_hms(x)

# You can see all the available time zones using the function OlsonNames,
OlsonNames()
