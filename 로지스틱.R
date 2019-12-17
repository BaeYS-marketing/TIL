getwd(); data(iris)

str(iris)

#로지스틱 회귀분석은 2가지가 기본 :  2가지로 데이터셋 설정, setosa제외 
'종속변수는 "factor" 데이터 타입으로 변경해줘야 한다!!!!'
logitdata <- subset(iris, Species =='versicolor'|Species=='virginica')
'로지스틱 회귀는 우선 2개; 0과 1로 나눈다. R에서는 먼저 들어오는 애를 0이 된다.
vericor = 0 , virginica =1'
str(logitdata)
head(logitdata)

#로짓분석
#종속변수 :범주형 ~ 
          #       독립변수 : 연속값 
?glm
m<-glm(Species ~ ., data=logitdata, family='binomial')  


#log취한 값으로 바뀌는 것 확인해보기
fitted(m)[c(1:5, 51:55)]   #앞/뒤에서 5개(virgicolor 5개, virginica 5개)



# 0~1까지의 범위에서 0.5를 기준으로 나누어 본다. 
class(logitdata$Species)
as.numeric(logitdata$Species)

f<-fitted(m) #0~1(실패할 확률 대비 성공확률이라는 비율에 대한 해석 _ 값에 대한 절대적 수치의 해석은 아니다.)

# 이산형에서 Y=1일 때를 기준으로 삼는다. 즉 .기준 P(Y=1) : virginica가 될 확률 
'여기서 y가 1이라는 것은 virginica가 될 확률..
versicolor=2 , virginica=3 : R은 들어오는 데이터 순서대로 인식한다.
로지스틱 안에서는 versicolor=0, verginia=1'

#1을 기준으로 한다!! => 1로는 virginica를 잡았다!!  ; (virginica(2) -1)  

#예측치==정답지 비교 _ R은 수치형으로 해줘야해서 조금 복잡하다. 문자형으로 지원 안됌
f
is_correct <- (ifelse(f>0.5, 1, 0) == (as.numeric(logitdata$Species)-2))   
head(is_correct)

#정확도 
sum(is_correct)
mean(is_correct)

'정확도가 98%가 된다.!'



#오늘까지 배운것의 전체 해석
"종속변수 : 그룹 (vrigicolor, virginica), 
독립변수 : 4개 (Sepal.Length, Sepal.Width, petal.Length, Petal.Width)

독립변수 4개에 따라서 그룹이(종속변수)가 달라진다."


#오늘 배운 로짓함수 적용순서
'Factor형 변환 , glm() , fitted(glm()) , cut-off 적용 , 실제값과 비교하여 정확도'