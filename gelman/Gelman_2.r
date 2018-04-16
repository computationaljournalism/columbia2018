
library(rpart)
library(dplyr)

primary = read.csv("https://github.com/computationaljournalism/columbia2018/raw/master/data/primary.csv",as.is=TRUE)

head(primary)
dim(primary)

names(primary)

select(filter(primary,state_postal=="NY"),winner,county_name)

table(primary$winner)

table(primary$winner,primary$pres04winner)

290/(290+163)

1047/(1047+740)

(163 + 740)

(163 + 740)/2261

table(primary$winner,primary$black06pct > 0.1)

# Error rate?


fractions = (1:500)/1000

n = length(fractions)
error = rep(0,n)

for(i in 1:n){
    
    # right branch
    tmp = select(filter(primary,black06pct > fractions[i]),winner)
    error.right = min(table(tmp))
    
    # left branch
    tmp = select(filter(primary,black06pct <= fractions[i]),winner)
    error.left = min(table(tmp))
    
    error[i] = error.left+error.right
}

options(repr.plot.width=8, repr.plot.height=5)

plot(fractions,error,xlab="percentage black",ylab="misclassification error",type="l")

range(primary$Bush04,na.rm=TRUE)

fractions = (100:900)/1000

n = length(fractions)
error = rep(0,n)

for(i in 1:n){
    
    # right branch
    tmp = select(filter(primary,Bush04 > fractions[i]),winner)
    error.right = min(table(tmp))
    
    # left branch
    tmp = select(filter(primary,Bush04 <= fractions[i]),winner)
    error.left = min(table(tmp))
    
    error[i] = error.left+error.right
}

plot(fractions,error,xlab="Bush margin",ylab="misclassification error",type="l")

library(rpart)

fit = rpart(winner~region+pres04margin+black06pct+hisp06pct+white06pct+
            growth+pct_less_30k+pct_more_100k+pct_hs_grad+pct_homeowner+POP05_SQMI,data=primary)

options(repr.plot.width=8, repr.plot.height=8)
par(xpd=TRUE)

plot(fit)
text(fit,use.n=TRUE,cex=0.8)

fit = rpart(winner~region+pres04margin+black06pct+hisp06pct+white06pct+
            growth+pct_less_30k+pct_more_100k+pct_hs_grad+pct_homeowner+POP05_SQMI,data=primary,cp=0.00001)

plot(fit)

options(repr.plot.width=8, repr.plot.height=5)

plotcp(fit)

printcp(fit)

options(repr.plot.width=8, repr.plot.height=8)

plot(prune(fit,0.01))

fit = glm(factor(winner)~region+pres04margin+black06pct+hisp06pct+white06pct+
          growth+pct_less_30k+pct_more_100k+pct_hs_grad+pct_homeowner+POP05_SQMI,
          data=primary,family=binomial)

summary(fit)

primary = mutate(primary,biwinner = winner=="obama")
head(primary)

options(repr.plot.width=8, repr.plot.height=5)

plot(biwinner~Bush04,data=primary,pch="|")

plot(biwinner~Bush04,data=primary,pch="|")
abline(lm(biwinner~Bush04,data=primary))

plot(biwinner~black06pct,data=primary,pch="|")
abline(lm(biwinner~black06pct,data=primary))

plot(biwinner~black06pct,data=primary,pch="|",col=ifelse(biwinner,"cyan","magenta"))
abline(lm(biwinner~black06pct,data=primary))

# ignore as slightly tedious "behind the scenes"
points(c(0.1,0.3,0.5,0.7,0.9),sapply(split(primary$biwinner,cut(primary$black06pct,seq(0,1,len=6))),mean,na.rm=TRUE),pch=19)
abline(v=c(0,0.2,0.4,0.6,0.8,1.0),lty=2)

plot(biwinner~Bush04,data=primary,pch="|",col=ifelse(biwinner,"cyan","magenta"))
abline(lm(biwinner~Bush04,data=primary))

# ignore as slightly tedious "behind the scenes"
points(c(0.1,0.3,0.5,0.7,0.9),sapply(split(primary$biwinner,cut(primary$Bush04,seq(0,1,len=6))),mean,na.rm=TRUE),pch=19)
abline(v=c(0,0.2,0.4,0.6,0.8,1.0),lty=2)

options(repr.plot.width=8, repr.plot.height=8)

plot(black06pct~pct_hs_grad,data=primary,col=ifelse(biwinner,"cyan","magenta"),pch=ifelse(biwinner,"1","0"))

fit = glm(factor(winner)~region+pres04margin+black06pct+hisp06pct+white06pct+
          growth+pct_less_30k+pct_more_100k+pct_hs_grad+pct_homeowner+POP05_SQMI,
          data=primary,family=binomial)

summary(fit)

election = read.csv("http://www.collingwoodresearch.com/uploads/8/3/6/0/8360930/county_data.csv",sep="\t")
head(election)

election = mutate(election,winner = ifelse(pct_clinton < pct_trump,"Trump","Clinton"))
head(election)

fit = rpart(winner~per_capita_income+pobama12cnty+percent_white,data=election)

par(xpd=TRUE)

plot(fit)
text(fit,use.n=TRUE,cex=0.8)
