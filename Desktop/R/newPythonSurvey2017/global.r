library(shiny)
library(dplyr)
library(tidyr)
library(ggplot2)
library(DT)
library(googleVis)
library(stringr)
library(maps)
library(mapproj)
data = read.csv('./data/pythondevsurvey2017_raw_data.csv', header=TRUE)
colnames(data)
colnames(data)[161] = "Age"
usage = data %>% select(., type=Is.Python.the.main.language.you.use.for.your.current.projects.)
usage <- data.frame(lapply(usage, as.character), stringsAsFactors=FALSE)
class(usage)
#usage %>% mutate(., result = ifelse(type == "No, I dont use Python for my current projects", result = "No", ifelse(type == "No, I use Python as a secondary language", result = "second", result = type))) 
usage = usage %>% group_by(., type) %>% summarise(count = length(type))
language = data %>% select(., "none" = 2, "Java" = 3, "JavaScript" = 4, "C/C++" = 5, "PHP" = 6, "C#" = 7, "Bash/Shell" = 8,
                        "SQL" = 14, "HTML" = 24)
language
ratio = rep(0,9)
ratio[1] = language %>% summarise(sum(!is.na(language$none))/length(language$none)) 
ratio[2] = language %>% summarise(sum(!is.na(language$Java))/length(language$Java))
ratio[3] = language %>% summarise(sum(!is.na(language$JavaScript))/length(language$JavaScript))
ratio[4] = language %>% summarise(sum(!is.na(language$'C/C++'))/length(language$'C/C++'))
ratio[5] = language %>% summarise(sum(!is.na(language$PHP))/length(language$PHP))
ratio[6] = language %>% summarise(sum(!is.na(language$'C#'))/length(language$'C#'))
ratio[7] = language %>% summarise(sum(!is.na(language$"Bash/Shell"))/length(language$"Bash/Shell"))
ratio[8] = language %>% summarise(sum(!is.na(language$"SQL"))/length(language$"SQL"))
ratio[9] = language %>% summarise(sum(!is.na(language$"HTML"))/length(language$"HTML"))
names = colnames(language)
division = data.frame(names)
division$ratio = as.numeric(ratio)
division
purpose = data %>% select(., "Eduction" = 26, "Data Analyst" = 27, "DevOps/System administration/Writing automation scripts" = 28,
                          "Software testing / Writing automated tests" = 29, "Software prototyping" = 30
                          , "Web development" = 31, "Machine learning" = 32,
                          "Mobile development" = 33, "Desktop development" = 34, "Computer graphics" = 35,
                          "Network programming" = 36, "Game development" = 37,
                          "Multimedia applications development" = 38, "Embedded development" = 39, 
                          "amming of web parsers / scrapers / crawlers" = 40, "other" = 41)
pratio = rep(0,16)
pratio[1] = purpose %>% summarise(sum(!is.na(purpose$Eduction))/length(purpose$Eduction)) 

pratio[2] = purpose %>% summarise(sum(!is.na(purpose$"Data Analyst"))/length(purpose$"Data Analyst")) 

pratio[3] = purpose %>% summarise(sum(!is.na(purpose$"DevOps/System administration/Writing automation scripts"))/
                                    length(purpose$"DevOps/System administration/Writing automation scripts")) 

pratio[4] = purpose %>% summarise(sum(!is.na(purpose$"Software testing / Writing automated tests"))/length(purpose$"Software testing / Writing automated tests")) 

pratio[5] = purpose %>% summarise(sum(!is.na(purpose$"Software prototyping"))/length(purpose$"Software prototyping")) 

pratio[6] = purpose %>% summarise(sum(!is.na(purpose$"Web development"))/length(purpose$"Web development")) 
pratio[7] = purpose %>% summarise(sum(!is.na(purpose$"Machine learning"))/length(purpose$"Machine learning")) 
pratio[8] = purpose %>% summarise(sum(!is.na(purpose$"Mobile development"))/length(purpose$"Mobile development")) 
pratio[9] = purpose %>% summarise(sum(!is.na(purpose$"Desktop development"))/length(purpose$"Desktop development")) 
pratio[10] = purpose %>% summarise(sum(!is.na(purpose$"Computer graphics"))/length(purpose$"Computer graphics")) 
pratio[11] = purpose %>% summarise(sum(!is.na(purpose$"Network programming"))/length(purpose$"Network programming")) 
pratio[12] = purpose %>% summarise(sum(!is.na(purpose$"Game development"))/length(purpose$"Game development")) 
pratio[13] = purpose %>% summarise(sum(!is.na(purpose$"Multimedia applications development"))/length(purpose$"Multimedia applications development")) 
pratio[14] = purpose %>% summarise(sum(!is.na(purpose$"Embedded development"))/
                                     length(purpose$"Embedded development")) 
pratio[15] = purpose %>% summarise(sum(!is.na(purpose$"amming of web parsers / scrapers / crawlers"))
                                   /length(purpose$"amming of web parsers / scrapers / crawlers")) 
pratio[16] = purpose %>% summarise(sum(!is.na(purpose$"other"))/length(purpose$"other")) 

pnumber = rep(0,16)
pnumber[1] = purpose %>% summarise(sum(!is.na(purpose$Eduction))) 

pnumber[2] = purpose %>% summarise(sum(!is.na(purpose$"Data Analyst"))) 

pnumber[3] = purpose %>% summarise(sum(!is.na(purpose$"DevOps/System administration/Writing automation scripts"))) 

pnumber[4] = purpose %>% summarise(sum(!is.na(purpose$"Software testing / Writing automated tests"))) 

pnumber[5] = purpose %>% summarise(sum(!is.na(purpose$"Software prototyping"))) 

pnumber[6] = purpose %>% summarise(sum(!is.na(purpose$"Web development"))) 
pnumber[7] = purpose %>% summarise(sum(!is.na(purpose$"Machine learning"))) 
pnumber[8] = purpose %>% summarise(sum(!is.na(purpose$"Mobile development"))) 
pnumber[9] = purpose %>% summarise(sum(!is.na(purpose$"Desktop development"))) 
pnumber[10] = purpose %>% summarise(sum(!is.na(purpose$"Computer graphics"))) 
pnumber[11] = purpose %>% summarise(sum(!is.na(purpose$"Network programming"))) 
pnumber[12] = purpose %>% summarise(sum(!is.na(purpose$"Game development"))) 
pnumber[13] = purpose %>% summarise(sum(!is.na(purpose$"Multimedia applications development"))) 
pnumber[14] = purpose %>% summarise(sum(!is.na(purpose$"Embedded development"))) 
pnumber[15] = purpose %>% summarise(sum(!is.na(purpose$"amming of web parsers / scrapers / crawlers"))) 
pnumber[16] = purpose %>% summarise(sum(!is.na(purpose$"other"))) 
pnames = colnames(purpose)
colnames(purpose)
p = data.frame(pnames)
p$pratio = as.numeric(pratio)
p$pnumber = as.numeric(pnumber)
p$pnumber
p %>%
  arrange(pnumber) %>%
  mutate(pnames=factor(pnames,pnames)) %>%
  ggplot(aes(x = pnames, y = pnumber, fill = pnames)) +
  geom_bar(stat="identity", alpha=0.2, width = 0.5) +
  theme_minimal() +
  theme(
    panel.grid = element_blank(),
    text = element_text(size=15), 
    plot.title = element_text(hjust = 0.5)
  )


usageRatio = data %>% select(., ratio = 141)

popularRatio = data %>% select(., ratio = 142)

teamPlayer = data %>% select(., team = 143)

i = data %>% select(., industry = 146)
ins = na.omit(i)
Industry = ins %>% group_by(., industry) %>% summarise(ratio = length(industry)/nrow(i)) %>% arrange(., desc(ratio)) %>% head(12)
#Industry %>% group_by(., industry) %>% summarise(count = length(industry))%>% arrange(desc(count)) %>% top_n(25, industry)
work = data %>% select(., DBA = 149, Arcgutect = 150, QA.engineer = 151
                       , Developer = 152, Technical.Support = 153, Data.Analyst = 154,
                       Business.Analyst = 155, Team.Lead = 156, Product.Manager = 157,
                       "CIO/CEO/CTO" = 158, Systems.Analyst = 159, Other = 160)

age = data %>% select(., range = 161)
age = na.omit(age)
age = age %>% group_by(., range) %>% summarise(number = length(range))
#ggplot(data = age, aes(x = range, y = number)) + geom_point(aes(color = class)) + geom_smooth(se = FALSE)
age$ymax = cumsum(age$number)
age$ymin = c(0, head(age$ymax, n=-1))
age$number


c = data %>% select(., country = 162)
Country = c %>% group_by(., country) %>% summarise(number = length(country)) %>% arrange(., desc(number)) %>% head(15)
Country
WorldData <- map_data('world')
WorldData %>% filter(region != "Antarctica") -> WorldData
WorldData <- fortify(WorldData)

choice = c("Python")