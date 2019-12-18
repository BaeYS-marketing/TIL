library(dplyr)
library(stringr)
getwd()
setwd("c:/semi-project/data/생활인구_데이터")
data<-read.csv("LOCAL_PEOPLE_20170101.csv")

options(scipen = 100)
dm <- read.csv("c:/semi-project/data/코딩결과_윤성/5.백화점_집계구_실제집계구.csv")
View(dm)
View(parse_data)


setwd("c:/semi-project/data/생활인구_데이터")

#알고리즘 : 폴더명, csv파일명 입력하면 읽기
readfile <- function(folder_name,file_name){
  file <-read.csv(cat("./",folder_name,file_name))
  return(file)
}


readfile('LOCAL_PEOPLE_201701','LOCAL_PEOPLE_20170101')

#날짜 변환
file_date <- str_sub(file_name, start=14, end=21)
file_date <- as.Date(file_date, format = '%Y%m%d')

#요일 추출
weekdays(file_date)

#readfile 후 평일 
if (file_data %in% c("화요일,수요일,목요일"){
  week_day <- file %>%
    select(contains(시간),총생활인구,contains(남자),contains(여자)) %>% 
    filter(집계구코드 %in% dm[[3]] , 시간대구분 %in% c(2,3,4,5) )
}

#readfile 후 주말
else if (file_data %in% c("토요일","일요일")){
  week_end <- file %>%
    select(contains(시간),총생활인구,contains(남자),contains(여자)) %>% 
    filter(집계구코드 %in% dm[[3]] , 시간대구분 %in% c(10:20) ) 
}


#디렉토리 list _ 변수 저장
fd_list <- dir(path="c:/semi-project/data/생활인구_데이터",)
fe_list <- dir(path="c:/semi-project/data/생활인구_데이터/LOCAL_PEOPLE_201701")


for 



