//
//  WeatherData.swift
//  WeatherDemo
//
//  Created by mwpark on 4/11/25.
//

import Foundation

struct WeatherData: Codable {
    // 온도
    var temperature: Double
    // 날씨 정보
    var description: String
    // 습도
    var humidity: Double
    // 풍속
    var windSpeed: Double
    // SFSymbol
    var symbolName: String
    
    init(temperature: Double, description: String, humidity: Double, windSpeed: Double, symbolName: String) {
        self.temperature = temperature
        self.description = description
        self.humidity = humidity
        self.windSpeed = windSpeed
        self.symbolName = symbolName
    }
}
