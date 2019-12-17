install.packages('nnet')
install.packages('aod')

library(nnet)
library(aod)
library(ggplot2)
 
# view the first few rows of the data
mydata <- read.csv("https://stats.idre.ucla.edu/stat/data/binary.csv")
head(mydata) # 데이터 확인
str(mydata) # admit:범주형, rank 순서형데이터 
summary(mydata) # 데이터 구조 확인

#apply 지정 func for문 없이 반복 
sapply(mydata, sd) # contingency table : xtabs(~ x + y, data)

#교차_도수분포표 (도수분포표: 범주~갯수) 
xtabs(~admit+rank, data=mydata)  # y: count로 고정적

#로짓에 맞게 데이터 변환 
mydata$rank <- factor(mydata$rank)

mylogit<- glm(admit~ gre+gpa+rank, data = mydata, family=binomial)
#glm(종속변수 : 무조건 범주형 : 아니더라도 내부적으로 자동변환 )

summary(mylogit)
