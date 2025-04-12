//
//  WeatherViewModel.swift
//  WeatherDemo
//
//  Created by mwpark on 4/11/25.
//

import Foundation
import CoreLocation

@MainActor
class WeatherViewModel: ObservableObject {
    @Published var weather: WeatherData?
    @Published var isLoading: Bool = false
    @Published var error: Error?
    
    func fetchWeather(for location: CLLocation) async {
        isLoading = true
        do {
            let fetchedData = try await WeatherService.fetchWeather(for: location)
            weather = fetchedData
        } catch {
            self.error = error
        }
        isLoading = false
    }
}
