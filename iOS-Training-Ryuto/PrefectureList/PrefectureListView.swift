//
//  PrefectureListView.swift
//  iOS-Training-Ryuto
//
//  Created by 岩本 竜斗 on 2023/06/06.
//

import SwiftUI

struct PrefectureListView: View {
    @State private var searchText: String = ""
    
    private var searchResults: [String] {
        get {
            if searchText.isEmpty { return [] }
            else {
                let filteredPrefectures = prefectures
                    .flatMap { $0.1 }
                    .filter { $0.contains(searchText) }
                
                return filteredPrefectures
            }
        }
    }
    
    private let hokkaido = Region(name: "北海道", prefectures: [Prefecture(name: "北海道", imageName: "Hokkaido")])
    private let tohoku = Region(name: "東北", prefectures: [
        Prefecture(name: "青森県", imageName: "Aomori"),
        Prefecture(name: "岩手県", imageName: "Iwate"),
        Prefecture(name: "宮城県", imageName: "Miyagi"),
        Prefecture(name: "秋田県", imageName: "Akita"),
        Prefecture(name: "山形県", imageName: "Yamagata"),
        Prefecture(name: "福島県", imageName: "Fukushima"),
    ])
    private let kanto = Region(name: "関東", prefectures: [
        Prefecture(name: "埼玉県", imageName: "Saitama"),
        Prefecture(name: "千葉県", imageName: "Chiba"),
        Prefecture(name: "東京都", imageName: "Tokyo"),
        Prefecture(name: "神奈川県", imageName: "Kanagawa"),
    ])
    private let koshin = Region(name: "甲信", prefectures: [
        Prefecture(name: "茨城県", imageName: "Ibaraki"),
        Prefecture(name: "栃木県", imageName: "Tochigi"),
        Prefecture(name: "群馬県", imageName: "Gunma"),
        Prefecture(name: "山梨県", imageName: "Yamanashi"),
        Prefecture(name: "長野県", imageName: "Nagano"),
    ])
    private let hokuriku = Region(name: "北陸", prefectures: [
        Prefecture(name: "新潟県", imageName: "Nigata"),
        Prefecture(name: "富山県", imageName: "Toyama"),
        Prefecture(name: "石川県", imageName: "Ishikawa"),
        Prefecture(name: "福井県", imageName: "Fukui"),
    ])
    private let tokai = Region(name: "東海", prefectures: [
        Prefecture(name: "岐阜県", imageName: "Gifu"),
        Prefecture(name: "静岡県", imageName: "Shizuoka"),
        Prefecture(name: "愛知県", imageName: "Aichi"),
        Prefecture(name: "三重県", imageName: "Mie"),
    ])
    private let kinki = Region(name: "近畿", prefectures: [
        Prefecture(name: "滋賀県", imageName: "Shiga"),
        Prefecture(name: "京都府", imageName: "Kyoto"),
        Prefecture(name: "大阪府", imageName: "Osaka"),
        Prefecture(name: "兵庫県", imageName: "Hyogo"),
        Prefecture(name: "奈良県", imageName: "Nara"),
        Prefecture(name: "和歌山県", imageName: "Wakayama"),
    ])
    private let chugoku = Region(name: "中国", prefectures: [
        Prefecture(name: "鳥取県", imageName: "Tottori"),
        Prefecture(name: "島根県", imageName: "Shimane"),
        Prefecture(name: "岡山県", imageName: "Okayama"),
        Prefecture(name: "広島県", imageName: "Hiroshima"),
        Prefecture(name: "山口県", imageName: "Yamakuchi"),
    ])
    
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
                                PrefectureRowView(prefecture: prefecture)
                            }
                        }
                    }
                } else {
                    ForEach(searchResults, id: \.self) { prefecture in
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
