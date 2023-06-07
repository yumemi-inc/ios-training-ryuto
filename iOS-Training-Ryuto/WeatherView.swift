//
//  WeatherView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct WeatherView: View {
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [.blue, .cyan]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Text("東京")
                    .font(.title)
                    .fontWeight(.bold)
                    .padding(.top, 20)
                    .padding(.bottom, 10)
                
                Text("2023年6月7日の天気")
                    .font(.title2)
                
                Spacer()
                    .frame(height: 100)
                
                HStack {
                    VStack(spacing: 30) {
                        Image(systemName: "sun.max.fill")
                            .resizable()
                            .scaledToFit()
                            .frame(width: 150, height: 150)
                            .foregroundColor(.orange)
                        
                        Text("晴れ")
                            .font(.system(size: 15))
                    }
                    
                    Spacer()
                        .frame(width: 40)
                    
                    VStack(spacing: 10) {
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
                            Text("最高: 15°")
                        }
                        .foregroundColor(.indigo)
                    }
                    .font(.system(size: 20))
                }
                Spacer()
            }
            .foregroundColor(.white)
        }
        .toolbar {
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
        WeatherView()
    }
}
