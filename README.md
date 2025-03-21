
# Time Series Forecasting with ARIMA Model

This repository presents a time series forecasting project using ARIMA and Seasonal ARIMA models on monthly data. The methodology includes seasonality detection, detrending, stationarity testing, and residual analysis.

이 프로젝트는 월별 시계열 데이터를 기반으로 ARIMA 및 Seasonal ARIMA 모델을 사용한 예측 프로젝트를 담고 있습니다. 계절성 제거, 추세 제거, 정상성 테스트, 잔차 분석 등의 과정을 포함합니다.

---

## Project Summary | 프로젝트 개요

- **Author**: Eun Lim  
- **Date**: February 12, 2021  
- **Course**: ECO374 - Winter 2021  
- **Language**: R  
- **Goal**: Forecast 12 periods ahead for an unknown time series  

---

## Methodology | 분석 방법론

- **Decomposition** of time series into trend (Tt), seasonality (St), and noise (εt)
- Deseasonalization via regression on seasonal dummies
- Detrending by first differencing (lag=1)
- Stationarity testing: **ADF Test**, **Ljung-Box Test**
- Model selection: `auto.arima()` with parameters (p=2, q=31)
- Forecasting: 12-period ahead values generated and plotted

---

## Results | 결과 요약

- Final model: ARIMA(1,0,2) with Seasonal ARIMA(2,0,0)
- Residuals tested and verified to be stationary
- 12-step forecast captured general upward trend and seasonality
- Forecast plots show strong alignment with observed fluctuation patterns

---

## How to Run | 실행 방법

1. Clone this repository:
```bash
git clone https://github.com/your-username/arima-timeseries-forecast.git
```

2. Open `Project_code.R` in RStudio

3. Install required packages:
```r
install.packages(c("forecast", "tseries", "ggplot2"))
```

4. Run the R script to generate plots and forecasts

---

## Repository Structure | 저장소 구조

```
/data              <- Input data file (if applicable)
/Project_code.R    <- R script for forecasting
/Project.pdf       <- Final report (with results and plots)
```

---

## Limitations & Suggestions | 한계 및 제안

- Forecast confidence intervals not shown → consider using `forecast()` package
- Residual diagnostics could include Shapiro-Wilk test and Q-Q plot
- KPSS test for stationarity is not included
- Model interpretability could benefit from clearer variable naming

---

## License

This project is licensed under the MIT License.

## Contact

For questions, contact [your_email@example.com]
