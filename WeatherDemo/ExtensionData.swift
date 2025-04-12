//
//  weatherExtensionData.swift
//  WeatherDemo
//
//  Created by mwpark on 4/12/25.
//

import Foundation
import WeatherKit

// weatherKit에서 제공하는 모든 날씨에 대해서 SFSymbols로 나타내기 위해서...
let weatherConditionImage: [String: String] = [
    "Blizzard": "wind.snow",
    "BlowingDust": "aqi.low",
    "BlowingSnow": "wind.snow",
    "Breezy": "wind",
    "Clear": "sun.max",
    "Cloudy": "cloud",
    "Drizzle": "cloud.drizzle",
    "Flurries": "cloud.snow",
    "Foggy": "cloud.fog",
    "FreezingDrizzle": "cloud.sleet",
    "FreezingRain": "cloud.sleet",
    "Frigid": "thermometer.snowflake",
    "Hail": "cloud.hail",
    "Haze": "sun.haze",
    "HeavyRain": "cloud.heavyrain",
    "HeavySnow": "snowflake",
    "Hot": "thermometer.sun",
    "Hurricane": "hurricane",
    "IsolatedThunderstorms": "cloud.bolt",
    "MostlyClear": "sun.max",
    "MostlyCloudy": "cloud.sun",
    "PartlyCloudy": "cloud.sun",
    "Rain": "cloud.rain",
    "ScatteredThunderstorms": "cloud.bolt.rain",
    "Sleet": "cloud.sleet",
    "Smoky": "smoke",
    "Snow": "cloud.snow",
    "StrongStorms": "cloud.bolt.rain",
    "SunFlurries": "cloud.sun",
    "SunShowers": "cloud.sun.rain",
    "Thunderstorms": "cloud.bolt.rain",
    "TropicalStorm": "tropicalstorm",
    "Windy": "wind",
    "WintryMix": "cloud.sleet"
]
