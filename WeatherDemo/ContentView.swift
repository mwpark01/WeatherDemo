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
    @State private var location: CLLocation?
    @State private var latitude: String = ""
    @State private var longitude: String = ""
    @State private var isDarkMode: Bool = false
    
    var body: some View {
        VStack {
            HStack {
                Spacer() // 오른쪽 정렬용
                Text("다크모드")
                    .font(.title2)
                
                Toggle("", isOn: $isDarkMode)
                    .labelsHidden() // 라벨 숨기기
            }
            .padding()
            Text("날씨 정보")
                .font(.title)
            
            if viewModel.isLoading {
                ProgressView("날씨 정보 가져오는중")
            } else {
                if let weatherData = viewModel.weather {
                    Text("온도: \(weatherData.temperature, specifier: "%.1f") °C")
                    Text("설명: \(weatherData.description)")
                    Text("습도: \(weatherData.humidity * 100, specifier: "%.1f") %")
                    Text("풍속: \(weatherData.windSpeed, specifier: "%.1f") m/s")
                }
                
            }
            
            Button(action: {
            }, label: {
                Image(systemName: "location.circle")
                    .resizable()
                    .frame(width: 30, height: 30)
            })
            
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
