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
    @Environment(\.dismiss) private var dismiss
    
    @State private var request: YumemiWeatherRequest? = nil
    
    var body: some View {
        ZStack {
            // 背景色を設定
            backgroundView()
            
            VStack(spacing: 100) {
                weatherInformationView()
                weatherDetailView()
                Spacer()
            }
            .foregroundColor(.white)
        }
        .onAppear {
            request = YumemiWeatherRequest(area: prefecture.id, date: Date.now)
            guard let jsonString = try? JSONHelper.shared.encodeToString(request) else { return }
            
            viewModel.fetchWeatherCondition(jsonString: jsonString)
        }
        .toolbar {
            // 再読み込みボタン
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    guard let jsonString = try? JSONHelper.shared.encodeToString(request) else { return }
                    
                    viewModel.fetchWeatherCondition(jsonString: jsonString)
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
                Text(DateHelper.shared.formatToString(date: weather.date, dateFormat: "yyyy年M月d日") + "の天気")
                    .font(.title2)
            }
        }
    }
    
    private func weatherDetailView() -> some View {
        VStack(spacing: 50) {
            HStack(spacing: 20) {
                switch viewModel.weather?.condition {
                case .sunny:
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.orange)
                    
                case .cloudy:
                    Image(systemName: "cloud.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.gray)
                    
                case .rainy:
                    Image(systemName: "cloud.rain.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.blue)
                case .none:
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        if let weather = viewModel.weather {
                            Text("最高: \(weather.maxTemperature)°")
                        }
                    }
                    .foregroundColor(.red)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        if let weather = viewModel.weather {
                            Text("最低: \(weather.minTemperature)°")
                        }
                    }
                    .foregroundColor(.indigo)
                }
                .font(.system(size: 20))
            }
            
            if let weather = viewModel.weather {
                Text(weather.condition.rawValue)
                    .font(.system(size: 25))
            }
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
