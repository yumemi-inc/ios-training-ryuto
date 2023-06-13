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
            LinearGradient(gradient: Gradient(colors: [.blue, .cyan]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Text(prefecture.id)
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                Text("2023年6月7日の天気")
                    .font(.title2)
                
                Spacer()
                    .frame(height: 100)
                
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
                
                Spacer()
                    .frame(height: 50)
                
                Text("晴れ")
                    .font(.system(size: 25))
                
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

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            WeatherView(prefecture: Prefecture(id: "東京都", imageName: "Tokyo"))
        }
    }
}
