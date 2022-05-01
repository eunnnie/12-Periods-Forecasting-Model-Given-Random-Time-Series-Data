library(tidyverse)
library(readxl)
library(forecast)
library(xlsx)
library(aTSA)
library(patchwork)

# load data

setwd("C:\\Users\\lsy76\\Desktop\\20-21\\winter\\ECO374\\Essay")
dat <- read_excel("essay data.xlsx") %>%
  na.omit

ts_dat <- ts(dat$y, frequency=12)

raw_plot<- autoplot(ts_dat, color = "dark blue") +
  ggtitle("Figure 1. Time Plot: Time Series Data")+
  ylab("values")+
  xlab("Time") +
  theme_bw()

# plot the time series

plot(raw_plot)

# regress y on seasonal dummies to deseasonalize.

n <- nrow(na.omit(dat))
Q1 =rep(c(1,0,0,0,0,0,0,0,0,0,0,0),n/12)
Q2 =rep(c(0,1,0,0,0,0,0,0,0,0,0,0),n/12)
Q3 =rep(c(0,0,1,0,0,0,0,0,0,0,0,0),n/12)
Q4 =rep(c(0,0,0,1,0,0,0,0,0,0,0,0),n/12)
Q5 =rep(c(0,0,0,0,1,0,0,0,0,0,0,0),n/12)
Q6 =rep(c(0,0,0,0,0,1,0,0,0,0,0,0),n/12)
Q7 =rep(c(0,0,0,0,0,0,1,0,0,0,0,0),n/12)
Q8 =rep(c(0,0,0,0,0,0,0,1,0,0,0,0),n/12)
Q9 =rep(c(0,0,0,0,0,0,0,0,1,0,0,0),n/12)
Q10 =rep(c(0,0,0,0,0,0,0,0,0,1,0,0),n/12)
Q11 =rep(c(0,0,0,0,0,0,0,0,0,0,1,0),n/12)
Q12 =rep(c(0,0,0,0,0,0,0,0,0,0,0,1),n/12)

ms <- lm(y~Q1+Q2+Q3+Q4+Q5+Q6+Q7+Q8+Q9+Q10+Q11, data=dat)

season_fit <- ts(ms$fitted.values, frequency = 12)

Seasonality <- season_fit

res <- ms$residuals

res_ts <- ts(res, frequency = 12)

Observed <- ts_dat
Seasonally_Adjusted <- res_ts
Seasonality <- season_fit

# plot seasonality and the seasonally adjusted series

autoplot(cbind(Seasonality, Seasonally_Adjusted), facets = TRUE, color ="dark blue") +
  ggtitle("Figure 2. Time Plot: Seasonality vs. Seasonally Adjusted")+
  ylab("values")+
  xlab("Time")+
  theme_bw()

# Detrend by 1st differencing

res_diff <- diff(res_ts)

# plot residual

autoplot(res_diff, color="dark blue")+
  ggtitle("Figure 3. Residual")+
  ylab("values")+
  xlab("Time") +
  theme_bw()

# Ljung-Box test 

Box.test(res_diff, lag=1, type='Ljung-Box')
Box.test(res_diff, lag=2, type='Ljung-Box')
Box.test(res_diff, lag=3, type='Ljung-Box')
Box.test(res_diff, lag=4, type='Ljung-Box')
Box.test(res_diff, lag=5, type='Ljung-Box')
Box.test(res_diff, lag=6, type='Ljung-Box')
Box.test(res_diff, lag=7, type='Ljung-Box')
Box.test(res_diff, lag=8, type='Ljung-Box')
Box.test(res_diff, lag=9, type='Ljung-Box')
Box.test(res_diff, lag=10, type='Ljung-Box')
Box.test(res_diff, lag=11, type='Ljung-Box')
Box.test(res_diff, lag=12, type='Ljung-Box')

# ADF

adf.test(res_diff)

# ACF PACF

acf<-ggAcf(res_diff, lag.max = 48) +
  ggtitle("Figure 4. Residual: ACF")+
  theme_bw()
pacf<-ggPacf(res_diff, lag.max = 48) +
  ggtitle("Figure 5. Residual: PACF")+
  theme_bw()

acf|pacf

# estimate model, and forecast residual series and y

mod <- auto.arima(res_diff, max.p = 31, max.q=2)
summary(mod)
pred <- predict(mod,n.ahead=12)
res_pred <- pred$pred
r <- tail(diffinv(res_pred,xi=tail(res,1)),12)
Q1 =c(1,0,0,0,0,0,0,0,0,0,0,0)
Q2 =c(0,1,0,0,0,0,0,0,0,0,0,0)
Q3 =c(0,0,1,0,0,0,0,0,0,0,0,0)
Q4 =c(0,0,0,1,0,0,0,0,0,0,0,0)
Q5 =c(0,0,0,0,1,0,0,0,0,0,0,0)
Q6 =c(0,0,0,0,0,1,0,0,0,0,0,0)
Q7 =c(0,0,0,0,0,0,1,0,0,0,0,0)
Q8 =c(0,0,0,0,0,0,0,1,0,0,0,0)
Q9 =c(0,0,0,0,0,0,0,0,1,0,0,0)
Q10 =c(0,0,0,0,0,0,0,0,0,1,0,0)
Q11 =c(0,0,0,0,0,0,0,0,0,0,1,0)
Q12 =c(0,0,0,0,0,0,0,0,0,0,0,1)

new_s <- data.frame(Q1,Q2,Q3,Q4,Q5,Q6,Q7,Q8,Q9,Q10,Q11)
season_pred <- ts(predict(ms, new_s), start=c(16,1), frequency = 12)  
y_pred <- season_pred+r
Forecasted_Residual <- res_pred
Forecasted <- y_pred
Observed_Residual <- res_diff

# plot residual series and y 

autoplot(cbind(Observed_Residual, Forecasted_Residual), facets = FALSE) +
  ggtitle("Figure 6. Time Plot: 12 Periods ahead Residual Forecasts")+
  ylab("values")+
  xlab("Time")
autoplot(cbind(Observed, Forecasted), facets = FALSE) +
  ggtitle("Figure 7. Time Plot: 12 Periods ahead Forecasts")+
  ylab("values")+
  xlab("Time")

write.xlsx(y_pred, file = "Eun Lim 1005280839.xlsx",
           sheetName = "Sheet1", append = FALSE)
