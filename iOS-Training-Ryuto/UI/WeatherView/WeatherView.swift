//
//  WeatherView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct WeatherView: View {
    let prefecture: Prefecture
    @Environment(\.dismiss) var dismiss
    @Environment(\.scenePhase) private var scenePhase
    @StateObject private var viewModel = WeatherViewModel()
    
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
        .overlay {
            if viewModel.isLoading {
                ZStack {
                    Color.black
                        .ignoresSafeArea()
                        .opacity(0.3)
                    ProgressView()
                }
                
            }
        }
        .alert("エラー発生", isPresented: .constant(viewModel.yumemiWeatherError != nil)) {
            Button("戻る") {
                viewModel.yumemiWeatherError = nil
                dismiss()
            }
            Button("OK") { viewModel.yumemiWeatherError = nil }
        } message: {
            Text(viewModel.yumemiWeatherError?.localizedDescription ?? "")
        }
        .task {
            await viewModel.asyncFetchWeather(area: prefecture.id, date: Date())
        }
        .onChange(of: scenePhase) { phase in
            if phase == .active {
                viewModel.yumemiWeatherError = nil
                Task {
                    await viewModel.asyncFetchWeather(area: prefecture.id, date: Date())
                }
            }
        }
        .toolbar {
            // 再読み込みボタン
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    Task {
                        await viewModel.asyncFetchWeather(area: prefecture.id, date: Date())
                    }
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                }
                .disabled(viewModel.isLoading)
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
            
            Text(weather.condition.localized)
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
