//
//  WeatherData.swift
//  WeatherDemo
//
//  Created by mwpark on 4/11/25.
//

import Foundation

struct WeatherData: Codable {
    var temperature: Double
    var description: String
    var humidity: Double
    var windSpeed: Double
    
    init(temperature: Double, description: String, humidity: Double, windSpeed: Double) {
        self.temperature = temperature
        self.description = description
        self.humidity = humidity
        self.windSpeed = windSpeed
    }
}
