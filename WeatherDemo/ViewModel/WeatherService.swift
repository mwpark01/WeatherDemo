//
//  WeatherService.swift
//  WeatherDemo
//
//  Created by mwpark on 4/11/25.
//

import Foundation
import WeatherKit
import CoreLocation

class WeatherService {
    static func fetchWeather(for location: CLLocation) async throws -> WeatherData {
        do {
            let service = WeatherKit.WeatherService()
            let weather = try await service.weather(for: location)
            let current = weather.currentWeather
            
            return WeatherData(
                temperature: current.temperature.value,
                description: current.condition.description,
                humidity: current.humidity,
                windSpeed: current.wind.speed.value
            )
        } catch {
            print("날씨 가져오기 실패: \(error)")
            throw error
        }
    }
}
