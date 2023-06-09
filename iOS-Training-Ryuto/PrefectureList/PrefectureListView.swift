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
                    .flatMap { $0.prefectures }
                    .filter { $0.id.contains(searchText) }
                
                return filteredPrefectures
            }
        }
    }
    
    private let regions: [Region] = [
        Region(id: "北海道", prefectures: [
            Prefecture(id: "北海道", imageName: "Hokkaido")
        ]),
        
        Region(id: "東北", prefectures: [
            Prefecture(id: "青森県", imageName: "Aomori"),
            Prefecture(id: "岩手県", imageName: "Iwate"),
            Prefecture(id: "宮城県", imageName: "Miyagi"),
            Prefecture(id: "秋田県", imageName: "Akita"),
            Prefecture(id: "山形県", imageName: "Yamagata"),
            Prefecture(id: "福島県", imageName: "Fukushima")
        ]),
        
        Region(id: "関東", prefectures: [
            Prefecture(id: "埼玉県", imageName: "Saitama"),
            Prefecture(id: "千葉県", imageName: "Chiba"),
            Prefecture(id: "東京都", imageName: "Tokyo"),
            Prefecture(id: "神奈川県", imageName: "Kanagawa")
        ]),
        
        Region(id: "甲信", prefectures: [
            Prefecture(id: "茨城県", imageName: "Ibaraki"),
            Prefecture(id: "栃木県", imageName: "Tochigi"),
            Prefecture(id: "群馬県", imageName: "Gunma"),
            Prefecture(id: "山梨県", imageName: "Yamanashi"),
            Prefecture(id: "長野県", imageName: "Nagano")
        ]),
        
        Region(id: "北陸", prefectures: [
           Prefecture(id: "新潟県", imageName: "Nigata"),
           Prefecture(id: "富山県", imageName: "Toyama"),
           Prefecture(id: "石川県", imageName: "Ishikawa"),
           Prefecture(id: "福井県", imageName: "Fukui")
       ]),
        
        Region(id: "東海", prefectures: [
            Prefecture(id: "岐阜県", imageName: "Gifu"),
            Prefecture(id: "静岡県", imageName: "Shizuoka"),
            Prefecture(id: "愛知県", imageName: "Aichi"),
            Prefecture(id: "三重県", imageName: "Mie")
        ]),
        
        Region(id: "近畿", prefectures: [
            Prefecture(id: "滋賀県", imageName: "Shiga"),
            Prefecture(id: "京都府", imageName: "Kyoto"),
            Prefecture(id: "大阪府", imageName: "Osaka"),
            Prefecture(id: "兵庫県", imageName: "Hyogo"),
            Prefecture(id: "奈良県", imageName: "Nara"),
            Prefecture(id: "和歌山県", imageName: "Wakayama")
        ]),
        
        Region(id: "中国", prefectures: [
            Prefecture(id: "鳥取県", imageName: "Tottori"),
            Prefecture(id: "島根県", imageName: "Shimane"),
            Prefecture(id: "岡山県", imageName: "Okayama"),
            Prefecture(id: "広島県", imageName: "Hiroshima"),
            Prefecture(id: "山口県", imageName: "Yamakuchi")
        ]),
        
        Region(id: "四国", prefectures: [
            Prefecture(id: "徳島県", imageName: "Tokushima"),
            Prefecture(id: "香川県", imageName: "Kagawa"),
            Prefecture(id: "愛媛県", imageName: "Ehime"),
            Prefecture(id: "高知県", imageName: "Kouchi")
        ]),
        
        Region(id: "九州", prefectures: [
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
                if searchResults.isEmpty {
                    ForEach(prefectures, id: \.0) { regionName, regionPrefectures in
                        Section(regionName) {
                            ForEach(regionPrefectures, id: \.self) { prefecture in
//                                PrefectureRowView(prefecture: prefecture)
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
