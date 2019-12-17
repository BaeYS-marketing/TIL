getwd()
setwd('C:\\R_statistics\\data')

#? yes or no 가 아니라 vigicolor virginica


#데이터셋 확인
drink <- read.csv("drink.csv",header=T)  #'과장 ' , '차장 ' 띄어쓰기 직접없애야 돼 
drink

str(drink)


library(class)
#로지스틱 회귀분석 : 종속변수가 범주형!!
# 종속변수에 대한 이항분포 - 로짓으로
model_info<- glm(지각여부 ~ 나이 + 결혼여부 + 자녀여부+ 체력 + 주량 + 직급 + 성별,
            family = binomial(link = logit), data = drink)

#w계수
print(model_info) 

#회귀계수 확인 : 부호를 통해 대략적인 방향성 확인
summary(model_info)

#회귀계수에 대한 _ log 값 해석 : 오즈비로 회귀계수 해석
exp(coef(model_info))



predict(model_info,drink, type ="response")


predict(model_info, drink, type="response") >=0.5

table(drink$지각여부, predict(model_info, drink, type="response")>0.5)



