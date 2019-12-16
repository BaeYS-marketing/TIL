#데이터 불러오기 , 구조 살피기
library(geosphere)

getwd()
setwd("C:\\semi-project\\data")

department <- read.csv("점포이름_위도_경도_주소.csv")
area <- read.csv("집계코드_위도_경도_주소.csv")


str(department)
str(area)

names(area)[1] <-"areaIndex"
names(area)[2] <-"whereArea"
head(area)

names(department)[1] <-"departIndex"
names(department)[2] <-"departName"
head(department)

#데이터 셋 결과
area
department


#빈 데이터셋 설정 : 행~ 집계구역 / 열 : 백화점 이름  / value 의미없음 
#1.관측치 갯수 확인 
d<-1:{length(department$departIndex)*length(area$areaIndex)}
length(d)

#2.빈 메트릭스 만들기 -> 데이터 프레임으로 전환 => distData
distanceData <- matrix(1:length(d),ncol = length(department$departName))
distData <-data.frame(distanceData)
names(distData) <- department$departName
row.names(distData) <- area$whereArea

View(head(distData))




#ex) 거리계산 함수 : distm(c(lon1, lat1), c(lon2, lat2), fun = distHaversine)
distm(c(127,37.5),c(127,37.6), fun = distHaversine)

# 편하게 dist(x,y)로 설정
dist <- function(x,y,z,w){
  dd<-distm(c(x,y),c(z,w),fun = distHaversine)
  return(dd)
}


nrow(distData)


# 거리계산한 것 disData 데이터셋에 push 하기
str(distData)
head(department)
head(area)
length(area$lon)


for (dpIndex in 1:ncol(distData)){
  for (arIndex in 1:nrow(distData)){
    distance<-dist(department$lon[dpIndex],department$lat[dpIndex],
                   area$lon[arIndex],area$lat[arIndex])
    distData[arIndex,dpIndex]<-distance
  }
}



#데이터 확인 
View(head(distData,10))


#데이터 저장
getwd()
write.csv(distData,"백화점 집계구 거리결과.csv")   #row idex가 칼럼으로 저장
