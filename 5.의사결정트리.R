rm(list=ls())
options(scipen=100)
weather_df <- read.csv("C:\\Users\\student\\Desktop\\semi_project\\Multicampus_semi\\data_proced\\whether_dust_merged_weekend.csv",
                       stringsAsFactors=FALSE)
depart_df <- read.csv("C:\\Users\\student\\Desktop\\semi_project\\Multicampus_semi\\data_proced\\department.csv", encoding="utf-8")

setwd('C:\\Users\\student\\Desktop\\semi_project\\Multicampus_semi\\local_people')
load('weekday.Rdata')
load('weekend.Rdata')

options(scipen=100)



str(res)
str(weather_df)
str(depart_df)

#install.packages("C50")
# install.packages("rattle")

library(C50)
library(rpart)
library(rpart.plot)
library(rattle)
library(party)
library(dplyr)

#res 날짜 : 팩터 -> 숫자
res$date<-as.character(res$date)
res$date<-as.numeric(res$date)


#res 데이터 행 필터링 ~weather_df
res_weather_dp <- res %>%
  filter(date %in% weather_df$date) %>% 
  filter(집계구 %in% depart_df$code)


#데이터프레임 전체 숫자형으로 바꾸기
res_weather_dp <- sapply(res_weather_dp,as.numeric) #simplify=TRUE : 리스트 출력
res_weather_dp <- as.data.frame(res_weather_dp)
warnings()


#결측치 처리 
res_weather_dp[is.na(res_weather_dp)] <-0.00001  #is.na()함수_ 데이터프레임에서 행_로우별 스칼라로 접근
sapply(res_weather_dp, function(x) ifelse(x<0.0001,round(digit = -5),x))


#데이터 합치기
names(depart_df) <-c('백화점','집계구')

weather_df[is.na(weather_df)]<-0
pop_w<-left_join(res_weather_dp,weather_df[-1], by="date")
pop_w<-left_join(pop_w,depart_df, by="집계구")

str(pop_w)
length(pop_w)

#데이터 정렬
df_res <- pop_w[,c(1:3,46,4:45)]
df_res<-rename(df_res,"department"='백화점')
str(df_res)


#일부 팩터형 전환
length(df_res)

#매트릭스로 전환 후 실행해서 팩터형으로 전환이 안된다.
df_res[c(44,45,46)]<-sapply(df_res[c(44,45,46)],as.factor)

'함수가 칼럼별로 적용됐다.'
#t<-as.factor(df_res[c(44,45,46)])

#각각하자 ..
df_res$dust_grade <- as.factor(df_res$dust_grade)
df_res$fine_grade <- as.factor(df_res$fine_grade)
df_res$IsDustyDay <- as.factor(df_res$IsDustyDay)


write.csv(df_res,"C:\\Users\\student\\Documents\\test.csv")
#df_res <- read.csv("C:\\Users\\student\\Documents\\test.csv",stringsAsFactors = F)



#데이터셋 분리 : 시간대 / 집계구 / 인구 / 기온 / 먼지
#setwd("~/")
#write.csv(df_res,"test.csv")


#1
TAP_df <- df_res %>% 
  select('시간대',"집계구",'총생활인구')
#2
TAPM_df <- df_res %>% 
  select('시간대','집계구','총생활인구',starts_with('남')) %>%
  mutate(총남자수=남10+남15+남20+남25+남30+남35+남40+
             남45+남50+남55+남60+남65)

#3
TAPW_df <- df_res %>% 
  select('시간대','집계구','총생활인구',starts_with('여')) %>%
  mutate(총여자수=여10+여15+여20+여25+여30+여35+여40+
               여45+여50+여55+여60+여65)

#4
TAPMW_df <- df_res %>% 
  select('시간대','집계구','총생활인구',starts_with('남'),starts_with('여'))

#5
TD_condition <- df_res %>% 
  select('mean_Temp',start('dust'),contains("fine"))


######################################################

#1 총인구 ~ 시간대 / 집계구 / 기온 / 먼지
test1<-cbind(TAP_df,TD_condition)

test1_tree <- rpart(총생활인구~., data=test1)
test1_ctree <- ctree(총생활인구~., data=test1)
fancyRpartPlot(test1_tree)
#plot(test1_ctree)


#2 총인구 ~ 시간대 / 기온 / 먼지
test2 <- test1[-2]

test2_tree <- rpart(총생활인구~., data=test2)
test2_ctree <- ctree(총생활인구~., data=test2 )
rpart.plot(test2_tree)
plot(test2_ctree)

#######################################################

#남자인구 ~ 시간대 / 집계구 / 기온 / 먼지
test3<-cbind(TAPM_df,TD_condition)
str(test3)
test3 <- test3[-3]

test3_tree <- rpart(총남자수~., data=test3)
test3_ctree <- ctree(총남자수~., data=test3)
fancyRpartPlot(test1_tree)
#plot(test1_ctree)


#2 남자인구 ~ 시간대 / 기온 / 먼지
test2 <- test1[-2]

test2_tree <- rpart(총생활인구~., data=test2)
test2_ctree <- ctree(총생활인구~., data=test2 )
rpart.plot(test2_tree)
plot(test2_ctree)

