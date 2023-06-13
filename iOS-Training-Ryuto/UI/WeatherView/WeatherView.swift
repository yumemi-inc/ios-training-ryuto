//
//  WeatherView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct WeatherView: View {
    let prefecture: Prefecture
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // 背景色を設定
            backgroundView()
            
            VStack {
                
                weatherInformationView()
                
                Spacer()
                    .frame(height: 100)
                
                weatherDetailView()
                
                Spacer()
            }
            .foregroundColor(.white)
        }
        .toolbar {
            // 再読み込みボタン
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                }
            }
        }
    }
}

extension WeatherView {
    func backgroundView() -> some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .cyan]),
                       startPoint: .top,
                       endPoint: .bottom)
        .ignoresSafeArea()
    }
    
    func weatherInformationView() -> some View {
        VStack(spacing: 20) {
            Text(prefecture.id)
                .font(.title)
                .fontWeight(.bold)
            
            Text("2023年6月7日の天気")
                .font(.title2)
        }
    }
    
    func weatherDetailView() -> some View {
        VStack(spacing: 50) {
            HStack(spacing: 20) {
                    Image(systemName: "sun.max.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 150, height: 150)
                        .foregroundColor(.orange)
                
                VStack(alignment: .leading, spacing: 10) {
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.up")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("最高: 30°")
                    }
                    .foregroundColor(.red)
                    
                    HStack(spacing: 3) {
                        Image(systemName: "arrow.down")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 20, height: 20)
                        Text("最低: 15°")
                    }
                    .foregroundColor(.indigo)
                }
                .font(.system(size: 20))
            }
            
            Text("晴れ")
                .font(.system(size: 25))
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
