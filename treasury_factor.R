library(tidyverse)
library(xts)
library(PerformanceAnalytics)
library(RStudioAMI)
library(Quandl)


Quandl.api_key("PfeDPr8vFMpZvLVwXGhC")

# load interest rate data
tickers = c("FRED/GS1", "FRED/GS2", "FRED/GS3", "FRED/GS5",
            "FRED/GS7", "FRED/GS10", "FRED/GS20", "FRED/GS30")

ust_rates = Quandl(tickers, type="xts")

colnames(ust_rates) <- c("UST1Y", "UST2Y", "UST3Y", "UST5Y", "UST7Y", "UST10Y", "UST20Y", "UST30Y")

# convert to monthly series
ust_rates <- ust_rates[endpoints(ust_rates, on="months"),]
ust_rates <- na.omit(ust_rates)

ust_rate_chg <- ust_rates - lag.xts(ust_rates)
ust_rate_chg <- na.omit(ust_rate_chg)

# calculate pca
ust_pca <- prcomp(ust_rate_chg)
ust_pca$scale
