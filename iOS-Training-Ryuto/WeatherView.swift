//
//  WeatherView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct WeatherView: View {
<<<<<<< HEAD
    var body: some View {
        Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
=======
    let prefecture: String
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStack {
            // 背景色を設定
            LinearGradient(gradient: Gradient(colors: [.blue, .cyan]),
                           startPoint: .top,
                           endPoint: .bottom)
            .ignoresSafeArea()
            
            VStack {
                Text(prefecture)
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
        .navigationBarBackButtonHidden(true)
        .toolbar {
            // 戻るボタン
            ToolbarItem(placement: .navigationBarLeading) {
                Button {
                    dismiss()
                } label: {
                    HStack(spacing: 3) {
                        Image(systemName: "chevron.backward")
                        Text("戻る")
                    }
                    .foregroundColor(.white)
                }
            }
            // 再読み込みボタン
            ToolbarItem(placement: .navigationBarTrailing) {
                Button {
                    
                } label: {
                    Image(systemName: "arrow.clockwise")
                        .foregroundColor(.white)
                }
            }
        }
>>>>>>> 7fb975a (feat: prefectureプロパティを追加)
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView(prefecture: "東京都")
    }
}
