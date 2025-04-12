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
    @StateObject private var currentLocationManager =  CurrentLocationManager()
    @State private var location: CLLocation?
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer()
                Text("다크모드")
                    .font(.title2)
                
                Toggle("", isOn: $isDarkMode)
                    .labelsHidden()
            }
            .padding()
            Text("날씨 정보")
                .font(.title)
                .bold()
            
            if viewModel.isLoading {
                ProgressView("날씨 정보 가져오는중")
            } else {
                if let weatherData = viewModel.weather {
                    VStack(alignment: .leading, spacing: 8) {
                        HStack {
                            Text("온도:")
                                .frame(alignment: .leading)
                            Text("\(weatherData.temperature, specifier: "%.1f") °C")
                        }
                        HStack {
                            Text("설명:")
                                .frame(alignment: .leading)
                            Text(weatherData.description)
                        }
                        HStack {
                            Text("습도:")
                                .frame(alignment: .leading)
                            Text("\(weatherData.humidity * 100, specifier: "%.1f") %")
                        }
                        HStack {
                            Text("풍속:")
                                .frame(alignment: .leading)
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
                TextField("경도 입력", text: $longitude)
                    .keyboardType(.decimalPad)
                
                Button(action: {
                    viewModel.error = nil
                    
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
            
            Text("예) 서울 시청) 위도: 37.5665, 경도: 126.9780")
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
