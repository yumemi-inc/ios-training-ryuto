//
//  PrefectureRowView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct PrefectureRowView: View {
    let prefecture: String
    
    var body: some View {
        HStack(spacing: 10) {
            Image(prefecture)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
            Text(prefecture)
        }
    }
}

struct PrefectureRowView_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureRowView(prefecture: "東京都")
    }
}
