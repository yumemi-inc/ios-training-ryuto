//
//  PrefectureListView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct PrefectureListView: View {
    @State private var searchText: String = ""
    
    private let prefectures = [
        ("北海道", ["北海道"]),
        ("東北", ["青森県", "岩手県", "宮城県", "秋田県", "山形県", "福島県"]),
        ("関東", ["埼玉県", "千葉県", "東京都", "神奈川県"]),
        ("甲信", ["茨城県", "栃木県", "群馬県", "山梨県", "長野県"]),
        ("北陸", ["新潟県", "富山県", "石川県", "福井県"]),
        ("東海", ["岐阜県", "静岡県", "愛知県", "三重県"]),
        ("近畿", ["滋賀県", "京都府", "大阪府", "兵庫県", "奈良県", "和歌山県"]),
        ("中国", ["鳥取県", "島根県", "岡山県", "広島県", "山口県"]),
        ("四国", ["徳島県", "香川県", "愛媛県", "高知県"]),
        ("九州", ["福岡県", "佐賀県", "長崎県", "熊本県", "大分県", "宮崎県", "鹿児島県", "沖縄県"])
    ]
    var body: some View {
        NavigationView {
            List {
                ForEach(prefectures, id: \.0) { regionName, regionPrefectures in
                    Section(regionName) {
                        ForEach(regionPrefectures, id: \.self) { prefecture in
                            HStack(spacing: 10) {
                                Image(prefecture)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50)
                                Text(prefecture)
                            }
                        }
                    }
                }
            }
            .navigationTitle("天気検索アプリ")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
        }
    }
}

struct PrefectureListView_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureListView()
    }
}
