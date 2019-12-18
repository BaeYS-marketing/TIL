#install.packages("rpart")
library(rpart)

help(rpart)

#CART : 목적변수가 범주형(지니지수), 연속형(분산이용_이진분리)

m<-rpart(Species~., data=iris)
m
'node), split n loss(못 맞춘것), yval : 목적변수(y_value)
1) 루트노드 150개 / setosa를 기준으로 100는 로스 (즉 50개만 세토사)

  2) 조건 :petal.length <2.45   /  "  /  ......'

#그래프 작업 
#1.뼈대
plot(m, margin =.1) 
'루트노드는 삭제된다.'

#2.텍스트
text(m,cex=1.2)


#좀 더 보강 그래프 필요; 몇가지 살펴보자

# install.packages('rpart.plot')
library(rpart.plot)

m
prp(m,type=4, extra=2, digits = 3)


'단점
모든 것이 이진법 사고 0 , 1
[경계선] 그래서 분류기준에 수렴해도 완전한 그 값이 아니면 0

조금씩 조금씩 오차가 누적되면서 
오류

분류기준에 대한 유효성검정이 이루어져야 한다
즉, p-value를 통한 구간추정 적용이 필요하다.'



#이런 통계유효성 보강 
'트리 만드는 속도는 조금 떨어지지만, 통계적 유효성!
단 아쉽지만, 속성개수가 30개 이하일 때만 지원 _ depth는 상관없다'

# install.packages("party")
library(party)

m
m2<- ctree(Species~. ,data=iris)
plot(m2)


str(iris)
