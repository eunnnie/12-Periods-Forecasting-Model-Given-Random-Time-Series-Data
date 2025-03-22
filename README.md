
## 📌 Project Summary | 프로젝트 요약

- **📅 Date**: February 12, 2021  
- **🛠 Tool | 도구**:  
  - R (`auto.arima()`, ACF, PACF, 시계열 테스트 함수 활용)  
- **🧪 Design | 설계**:  
  - 월별 시계열 데이터 분석 (계절성 + 추세 포함)  
  - 회귀분석과 차분을 이용한 시계열 분해 및 예측  
- **🎯 Goal | 목표**:  
  - 주어진 데이터를 기반으로 **향후 12개월 예측**  
  - 계절성·추세·불규칙성을 분리해 명확한 예측 수행

---

## 📊 Variables & Structure | 변수 및 시계열 구조

- **Yₜ (시계열 값 | time series value)**  
  = **Tₜ (추세 | trend)** + **Sₜ (계절성 | seasonality)** + **εₜ (오차 | error)**  
- 분석 대상은 **비정상 시계열**로, 계절성 제거 후 추세 제거 필요

---

## 🔍 Methodology | 분석 방법

1. **시각적 진단**: 추세와 계절성이 뚜렷한 패턴 발견  
2. **계절성 제거**: 회귀 기반 더미변수 사용  
3. **추세 제거**: 1차 차분(first differencing)  
4. **잔차 진단**:  
   - Ljung-Box Test → 자기상관 존재 (모델링 필요)  
   - Augmented Dickey-Fuller Test → 정상성 확보됨  
5. **ARIMA 모델링**:  
   - ACF → 최대 q = 31  
   - PACF → 최대 p = 2  
   - 최종 모델: **ARIMA(1,0,2) + SARIMA(2,0,0)**  
6. **12개월 예측 수행 및 재조합**:  
   - 추세와 계절성을 다시 더해 전체 예측값 생성

---

## 🧠 Interpretation | 해석

- 📈 이 시계열은 **계절 반복 + 불규칙한 추세**가 섞여 있어 단순 예측이 어렵습니다.  
- 🔍 따라서 분석자는 먼저 **계절성과 추세를 따로 떼어낸 후**, 잔차(오차)의 패턴을 분석해 예측 모델을 세웠습니다.  
- 🤖 이 방식은 마치 날씨 예측에서 "평년 기온 + 계절 패턴 + 오늘의 특이점"을 따로 분석하는 것과 유사합니다.  
- 결과적으로, **예측값이 원래 데이터처럼 반복적이고 점진적으로 증가하는 모습**을 재현해낼 수 있었습니다.

---

## 🧾 Conclusion | 결론

- ✅ 이 프로젝트는 **현실적인 시계열 데이터를 예측하는 정석적인 방식**을 따라 분석했습니다. 
- 🛠 단순한 ARIMA가 아닌, **계절성 제거 → 추세 제거 → ARIMA 예측 → 재조합**이라는 구조적 접근을 통해  
  예측의 정확도와 신뢰도를 높일 수 있었습니다. 
- 📊 결과 예측치는 원래의 계절 패턴과 추세 흐름을 매우 유사하게 재현하여, **실제 정책·마케팅·수요 예측 등에 응용 가능**합니다.
- 💡 특히, 반복적 패턴이 있는 데이터(예: 전력 수요, 제품 판매량, 방문자 수 등)에 매우 효과적인 접근입니다.
