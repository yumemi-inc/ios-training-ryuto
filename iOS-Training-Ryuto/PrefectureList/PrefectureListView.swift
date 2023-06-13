//
//  PrefectureListView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct PrefectureListView: View {
    @State private var searchText: String = ""
    
    private var searchResults: [Prefecture] {
        get {
            if searchText.isEmpty { return [] }
            else {
                let filteredPrefectures = regions
                    .flatMap { $1 }
                    .filter { $0.id.contains(searchText) }
                
                return filteredPrefectures
            }
        }
    }
    
    private let regions: [(String, [Prefecture])] = [
        ("北海道",  [Prefecture(id: "北海道", imageName: "Hokkaido")]),
        ("東北", [
            Prefecture(id: "青森県", imageName: "Aomori"),
            Prefecture(id: "岩手県", imageName: "Iwate"),
            Prefecture(id: "宮城県", imageName: "Miyagi"),
            Prefecture(id: "秋田県", imageName: "Akita"),
            Prefecture(id: "山形県", imageName: "Yamagata"),
            Prefecture(id: "福島県", imageName: "Fukushima")
        ]),
        ("関東", [
            Prefecture(id: "埼玉県", imageName: "Saitama"),
            Prefecture(id: "千葉県", imageName: "Chiba"),
            Prefecture(id: "東京都", imageName: "Tokyo"),
            Prefecture(id: "神奈川県", imageName: "Kanagawa")
        ]),
        ("甲信", [
            Prefecture(id: "茨城県", imageName: "Ibaraki"),
            Prefecture(id: "栃木県", imageName: "Tochigi"),
            Prefecture(id: "群馬県", imageName: "Gunma"),
            Prefecture(id: "山梨県", imageName: "Yamanashi"),
            Prefecture(id: "長野県", imageName: "Nagano")
        ]),
        ("北陸", [
            Prefecture(id: "新潟県", imageName: "Nigata"),
            Prefecture(id: "富山県", imageName: "Toyama"),
            Prefecture(id: "石川県", imageName: "Ishikawa"),
            Prefecture(id: "福井県", imageName: "Fukui")
        ]),
        ("東海", [
            Prefecture(id: "岐阜県", imageName: "Gifu"),
            Prefecture(id: "静岡県", imageName: "Shizuoka"),
            Prefecture(id: "愛知県", imageName: "Aichi"),
            Prefecture(id: "三重県", imageName: "Mie")
        ]),
        ("近畿", [
            Prefecture(id: "滋賀県", imageName: "Shiga"),
            Prefecture(id: "京都府", imageName: "Kyoto"),
            Prefecture(id: "大阪府", imageName: "Osaka"),
            Prefecture(id: "兵庫県", imageName: "Hyogo"),
            Prefecture(id: "奈良県", imageName: "Nara"),
            Prefecture(id: "和歌山県", imageName: "Wakayama")
        ]),
        ("中国", [
            Prefecture(id: "徳島県", imageName: "Tokushima"),
            Prefecture(id: "香川県", imageName: "Kagawa"),
            Prefecture(id: "愛媛県", imageName: "Ehime"),
            Prefecture(id: "高知県", imageName: "Kouchi")
        ]),
        ("四国", [
            Prefecture(id: "徳島県", imageName: "Tokushima"),
            Prefecture(id: "香川県", imageName: "Kagawa"),
            Prefecture(id: "愛媛県", imageName: "Ehime"),
            Prefecture(id: "高知県", imageName: "Kouchi")
        ]),
        ("九州", [
            Prefecture(id: "福岡県", imageName: "Fukuoka"),
            Prefecture(id: "佐賀県", imageName: "Saga"),
            Prefecture(id: "長崎県", imageName: "Nagasaki"),
            Prefecture(id: "熊本県", imageName: "Kumamoto"),
            Prefecture(id: "大分県", imageName: "Oita"),
            Prefecture(id: "宮崎県", imageName: "Miyazaki"),
            Prefecture(id: "鹿児島県", imageName: "Kagoshima"),
            Prefecture(id: "沖縄県", imageName: "Okinawa")
        ])
    ]
    
    var body: some View {
        NavigationView {
            List {
                if searchResults.isEmpty {
                    ForEach(regions, id: \.0) { region, prefectures in
                        Section(region) {
                            ForEach(prefectures) { prefecture in
                                PrefectureRowView(prefecture: prefecture)
                            }
                        }
                    }
                } else {
                    ForEach(searchResults) { prefecture in
                        PrefectureRowView(prefecture: prefecture)
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
