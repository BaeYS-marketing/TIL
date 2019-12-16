setwd("C:\\semi-project\\data")
distance <- read.csv("백화점 집계구 거리결과.csv")


str(distance)


#value가 최소값인 열index 추출 알고리즘

#1
min(distance[1])
which(distance[2]==min(distance[2]))         

#2-1
#집계구가 칼럼으로 저장됐을 때인 지금
distance$X[which(distance[2]==min(distance[2]))]

#2-2
#원래 목적이었던 이름이었을 경우 
row.names(distance[3]==reuslt)



#for문으로 거리 최소값만의 데이터셋 구하기
#1 : 백화점~집계구 빈 데이터셋
data<-matrix(1:25, ncol=25)
data<- data.frame(data)
names(data) <- names(distance)[-1]
row.name<-"해당 집계구"

data


#1-2 : 백화점~최소거리 빈 데이터셋
min_dist<- c()


#2 데이터셋 알고리즘
options(scipen = 100)

for (i in (2:length(distance))){
  index <- which(distance[i] == min(distance[i]))
  result <- distance$X[index]
  #result<-unique(result)   1.117051e+12 1.117051e+12  -> 1117051030401 1117051030402
  data[1,i-1] <- result[1]
  min_dist[i-1] <- min(distance[i])
}

data
min_dist

final_result <-rbind(data,min_dist)
row.names(final_result) <- c('해당집계구', '백화점과 집계구 거리')

write.csv(final_result,'백화점-집계구(중복제거).csv')




''''''''''''''''위 : 중복 제거 /  밑 : 중복 포함시키기''''''''''''''''''



#2-2
data2 <- list()
options(scipen = 100)
for (i in(2:length(distance))){
  index <- which(distance[i] == min(distance[i]))
  result <- distance$X[index]
  #data2 <- append(data2,result)
  data2 <- append(data2,list(result))
}

data2


#2-3
names(data2) <- names(distance)[-1]
data2

data3 = as.data.frame(unlist(data2))

write.csv(data3,"백화점-집계구(중복포함).csv")
