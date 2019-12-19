library(party)


#귀무가설에 대한 P-value

'1) statistic : 검정통계량
 
 2) ozone <= 19 : 이 분류를 통해서 나눠지는 두개의 그룹 ~ 차이가 없다(귀무가설) 
                   
 3) criterion = 0.964
     P-vale ~ 0.336
= 1- criterion

 4) * : 분개 완료 
'


str(airquality)

air_ctree<- ctree(Temp~Solar.R + Wind + Ozone , data=airquality)
plot(air_ctree)
