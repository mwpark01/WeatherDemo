//
//  ContentView.swift
//  WeatherDemo
//
//  Created by mwpark on 4/11/25.
//

import SwiftUI
import CoreLocation

struct ContentView: View {
    @StateObject private var viewModel = WeatherViewModel()
    // 현재 위치 값을 가져오는 변수
    @StateObject private var currentLocationManager =  CurrentLocationManager()
    // 테스트 용 데이터
    @State private var garaWeatherData = WeatherData(temperature: 21.0, description: "Hail", humidity: 0.23, windSpeed: 3.4)
    @State private var location: CLLocation?
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    // 다크모드 관련 변수
    @State private var isDarkMode: Bool = false
    // 키보드 숨기기 관련 변수
    @FocusState private var isFocused: Bool
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("Dark Mode")
                    .font(.title3)
                
                Toggle("", isOn: $isDarkMode)
                    .labelsHidden()
            }
            .padding()

            if viewModel.isLoading {
                ProgressView("날씨 정보 가져오는중")
            } else {
                if let weatherData = viewModel.weather {
                    VStack() {
                        Image(systemName: weatherConditionImage[weatherData.description] ?? "questionmark")
                            .resizable()
                            .frame(width: 100, height: 100)
                            .scaledToFit()
                            Text("\(weatherData.temperature, specifier: "%.1f") °C")
                                .font(.system(size: 50))
            
                            Text(weatherData.description)
                                .font(.system(size: 30))
                            
                        HStack {
                            Image(systemName: "humidity")
                            Text("\(weatherData.humidity * 100, specifier: "%.1f") %")
                            
                            Image(systemName: "wind")
                            Text("\(weatherData.windSpeed, specifier: "%.1f") m/s")
                        }
                    }
                }
            }
            
            HStack {
                Button(action: {
                    Task {
                        if let location = currentLocationManager.location {
                            await viewModel.fetchWeather(for: location)
                        }
                    }
                }, label: {
                    Image(systemName: "location.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
                
                Button(action: {
                    viewModel.weather = nil
                    latitude = ""
                    longitude = ""
                    location = nil
                }, label: {
                    Image(systemName: "arrow.clockwise.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
            }
            HStack {
                TextField("위도 입력", text: $latitude)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                TextField("경도 입력", text: $longitude)
                    .keyboardType(.decimalPad)
                    .focused($isFocused)
                
                Button(action: {
                    viewModel.error = nil
                    isFocused = false
                    
                    if let lat = Double(latitude), let lon = Double(longitude) {
                        location = CLLocation(latitude: lat, longitude: lon)
                        Task {
                            if let location {
                                await viewModel.fetchWeather(for: location)
                            }
                        }
                    }
                }, label: {
                    Image(systemName: "magnifyingglass.circle")
                        .resizable()
                        .frame(width: 30, height: 30)
                })
            }
            .padding()
            
            Text("예) 서울 시청 | 위도: 37.5665, 경도: 126.9780")
            if let error = viewModel.error {
                Text(error.localizedDescription)
                    .foregroundStyle(.red)
            }
        }
        .preferredColorScheme(isDarkMode ? .dark : .light)
    }
}

#Preview {
    ContentView()
}
