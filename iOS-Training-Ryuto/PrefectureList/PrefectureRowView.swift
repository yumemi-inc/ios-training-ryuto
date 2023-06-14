//
//  PrefectureRowView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct PrefectureRowView: View {
    let prefecture: Prefecture
    @Environment(\.colorScheme) private var colorScheme
    
    var body: some View {
        HStack(spacing: 10) {
            Image(prefecture.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: 50)
                .colorInvert(if: colorScheme == .dark) // ダークモード時に色を反転
            
            Text(prefecture.id)
        }
    }
}

private extension View {
    @ViewBuilder
    func colorInvert(if condition: Bool) -> some View {
        if condition { self.colorInvert() }
        else { self }
    }
}

struct PrefectureRowView_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureRowView(prefecture: Prefecture(id: "東京都", imageName: "Tokyo"))
    }
}
