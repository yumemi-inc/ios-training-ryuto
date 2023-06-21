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
        if searchText.isEmpty { return [] }
        else {
            let filteredPrefectures = regions
                .flatMap { $1 }
                .filter { $0.id.contains(searchText) }
            
            return filteredPrefectures
        }
    }
    
    private let regions: [(String, [Prefecture])] = [
        ("北海道",  [Prefecture(id: "北海道", imageName: R.image.hokkaido.name)]),
        ("東北", [
            Prefecture(id: "青森県", imageName: R.image.aomori.name),
            Prefecture(id: "岩手県", imageName: R.image.iwate.name),
            Prefecture(id: "宮城県", imageName: R.image.miyagi.name),
            Prefecture(id: "秋田県", imageName: R.image.akita.name),
            Prefecture(id: "山形県", imageName: R.image.yamagata.name),
            Prefecture(id: "福島県", imageName: R.image.fukushima.name)
        ]),
        ("関東", [
            Prefecture(id: "埼玉県", imageName: R.image.saitama.name),
            Prefecture(id: "千葉県", imageName: R.image.chiba.name),
            Prefecture(id: "東京都", imageName: R.image.tokyo.name),
            Prefecture(id: "神奈川県", imageName: R.image.kanagawa.name)
        ]),
        ("甲信", [
            Prefecture(id: "茨城県", imageName: R.image.ibaraki.name),
            Prefecture(id: "栃木県", imageName: R.image.tochigi.name),
            Prefecture(id: "群馬県", imageName: R.image.gunma.name),
            Prefecture(id: "山梨県", imageName: R.image.yamanashi.name),
            Prefecture(id: "長野県", imageName: R.image.nagano.name)
        ]),
        ("北陸", [
            Prefecture(id: "新潟県", imageName: R.image.nigata.name),
            Prefecture(id: "富山県", imageName: R.image.toyama.name),
            Prefecture(id: "石川県", imageName: R.image.ishikawa.name),
            Prefecture(id: "福井県", imageName: R.image.fukui.name)
        ]),
        ("東海", [
            Prefecture(id: "岐阜県", imageName: R.image.gifu.name),
            Prefecture(id: "静岡県", imageName: R.image.shizuoka.name),
            Prefecture(id: "愛知県", imageName: R.image.aichi.name),
            Prefecture(id: "三重県", imageName: R.image.mie.name)
        ]),
        ("近畿", [
            Prefecture(id: "滋賀県", imageName: R.image.shiga.name),
            Prefecture(id: "京都府", imageName: R.image.kyoto.name),
            Prefecture(id: "大阪府", imageName: R.image.osaka.name),
            Prefecture(id: "兵庫県", imageName: R.image.hyogo.name),
            Prefecture(id: "奈良県", imageName: R.image.nara.name),
            Prefecture(id: "和歌山県", imageName: R.image.wakayama.name)
        ]),
        ("中国", [
            Prefecture(id: "鳥取県", imageName: R.image.tottori.name),
            Prefecture(id: "島根県", imageName: R.image.shimane.name),
            Prefecture(id: "岡山県", imageName: R.image.okayama.name),
            Prefecture(id: "広島県", imageName: R.image.hiroshima.name),
            Prefecture(id: "山口県", imageName: R.image.yamaguchi.name),
        ]),
        ("四国", [
            Prefecture(id: "徳島県", imageName: R.image.tokushima.name),
            Prefecture(id: "香川県", imageName: R.image.kagawa.name),
            Prefecture(id: "愛媛県", imageName: R.image.ehime.name),
            Prefecture(id: "高知県", imageName: R.image.kouchi.name)
        ]),
        ("九州", [
            Prefecture(id: "福岡県", imageName: R.image.fukuoka.name),
            Prefecture(id: "佐賀県", imageName: R.image.saga.name),
            Prefecture(id: "長崎県", imageName: R.image.nagasaki.name),
            Prefecture(id: "熊本県", imageName: R.image.kumamoto.name),
            Prefecture(id: "大分県", imageName: R.image.oita.name),
            Prefecture(id: "宮崎県", imageName: R.image.miyazaki.name),
            Prefecture(id: "鹿児島県", imageName: R.image.kagoshima.name),
            Prefecture(id: "沖縄県", imageName: R.image.okinawa.name)
        ])
    ]
    
    var body: some View {
        NavigationView {
            List {
                if searchResults.isEmpty {
                    ForEach(regions, id: \.0) { region, prefectures in
                        Section(region) {
                            ForEach(prefectures) { prefecture in
                                NavigationLink(destination: WeatherView(prefecture: prefecture)) {
                                    PrefectureRowView(prefecture: prefecture)
                                        .accessibilityIdentifier("prefecture_list_row")
                                }
                            }
                        }
                    }
                } else {
                    ForEach(searchResults) { prefecture in
                        NavigationLink(destination: WeatherView(prefecture: prefecture)) {
                            PrefectureRowView(prefecture: prefecture)
                                .accessibilityIdentifier("prefecture_list_row")
                        }
                    }
                }
            }
            .accessibilityIdentifier("prefecture_list")
            .navigationTitle("天気検索アプリ")
            .navigationBarTitleDisplayMode(.inline)
            .searchable(text: $searchText,
                        placement: .navigationBarDrawer(displayMode: .always))
        }
        .tint(.white)
    }
}

struct PrefectureListView_Previews: PreviewProvider {
    static var previews: some View {
        PrefectureListView()
    }
}
