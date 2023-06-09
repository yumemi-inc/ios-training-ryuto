//
//  WeatherView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct WeatherView: View {
    let prefecture: Prefecture
    @ObservedObject private var viewModel = WeatherViewModel()
    
    
    var body: some View {
        ZStack {
            // 背景色を設定
            backgroundView()
            
            VStack(spacing: 100) {
                weatherInformationView()
                if let weather = viewModel.weather {
                    weatherDetailView(weather: weather)
                }
                
                Spacer()
            }
            .foregroundColor(.white)
        }
        .onAppear {
            viewModel.fetchWeatherCondition(area: prefecture.id, date: Date.now)
        }
        .toolbar {
            // 再読み込みボタン
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    viewModel.fetchWeatherCondition(area: prefecture.id, date: Date.now)
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

extension WeatherView {
    private func backgroundView() -> some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .cyan]),
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    private func weatherInformationView() -> some View {
        VStack(spacing: 20) {
            Text(prefecture.id)
                .font(.title)
                .fontWeight(.bold)
            
            if let weather = viewModel.weather {
                Text(DateHelper.formatToString(date: weather.date, dateFormat: "yyyy年M月d日") + "の天気")
                    .font(.title2)
            }
        }
    }
    
    private func weatherDetailView(weather: Weather) -> some View {
        VStack(spacing: 50) {
            HStack(spacing: 20) {
                Image(systemName: weather.condition.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
                    .foregroundColor(weather.condition.imageColor)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("最高: \(weather.maxTemperature)°")
                    }
                    .foregroundColor(.red)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        
                        Text("最低: \(weather.minTemperature)°")
                    }
                    .foregroundColor(.indigo)
                }
                .font(.system(size: 20))
            }
            
            Text(weather.condition.rawValue)
                .font(.system(size: 25))
        }
    }
}

private extension WeatherCondition {
    var imageName: String {
        switch self {
        case .sunny:
            return "sun.max.fill"
        case .cloudy:
            return "cloud.fill"
        case .rainy:
            return "cloud.rain.fill"
        }
    }
    
    var imageColor: Color {
        switch self {
        case .sunny:
            return .orange
        case .cloudy:
            return .gray
        case .rainy:
            return .blue
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(prefecture: Prefecture(id: "東京都", imageName: "Tokyo"))
        }
    }
}
