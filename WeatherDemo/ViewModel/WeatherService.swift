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
    // 해당 위치의 현재 날씨 정보를 리턴하는 함수
    static func fetchWeather(for location: CLLocation) async throws -> WeatherData {
        do {
            let service = WeatherKit.WeatherService()
            // 해당 위치의 날씨 정보를 async/await으로 가져온다.
            let weather = try await service.weather(for: location)
            // 그 정보들 중 현재 날씨를 가져온다.
            let current = weather.currentWeather
            
            return WeatherData(
                temperature: current.temperature.value,
                description: current.condition.description,
                humidity: current.humidity,
                windSpeed: current.wind.speed.value
            )
        } catch {
            print("날씨 가져오기 실패: \(error)")
            // 에러 발생시 이 함수를 호출한 곳(상위)으로 error를 throw한다.
            throw error
        }
    }
}
