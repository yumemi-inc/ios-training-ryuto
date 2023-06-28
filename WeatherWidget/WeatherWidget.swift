//
//  WeatherWidget.swift
//  WeatherWidget
//
//  Created by 岩本 竜斗 on 2023/06/27.
//

import WidgetKit
import SwiftUI
import Intents
import Combine

struct Provider: IntentTimelineProvider {
    let client: YumemiWeatherAPIClient
    @State var weather: Weather?
    
    init() {
        client = YumemiWeatherAPIClient()
        client.delegate = self
    }
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), weather: nil, configuration: ConfigurationIntent())
    }

    func getSnapshot(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), weather: nil, configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: ConfigurationIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        var entries: [SimpleEntry] = []
        
        let jsonString = """
            {
                "area": "tokyo",
                "date": "2023-06-16T12:00:00+09:00"
            }
            """

        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
        let currentDate = Date()
        for hourOffset in 0 ..< 5 {
            let entryDate = Calendar.current.date(byAdding: .hour, value: hourOffset, to: currentDate)!
            client.fetchWeatherCondition(jsonString: jsonString)
            let entry = SimpleEntry(date: entryDate, weather: weather, configuration: configuration)
            entries.append(entry)
        }

        let timeline = Timeline(entries: entries, policy: .atEnd)
        completion(timeline)
    }
}

extension Provider: YumemiWeatherAPIClientDelegate {
    func weatherFetchDidComplete(with result: Result<Weather?, Error>) {
        switch result {
        case .success(let weather):
            self.weather = weather
        case .failure(let error):
            print(error)
        }
    }
}

struct SimpleEntry: TimelineEntry {
    let date: Date
    let weather: Weather?
    let configuration: ConfigurationIntent
}

struct WeatherWidgetEntryView : View {
    var entry: Provider.Entry
    
    var body: some View {
        Text(entry.weather?.condition.localized ?? "")
//        Text("Hello World")
            .onAppear {

            }
    }
}

struct WeatherWidget: Widget {
    let kind: String = "WeatherWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(kind: kind, intent: ConfigurationIntent.self, provider: Provider()) { entry in
            WeatherWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
    }
}

struct WeatherWidget_Previews: PreviewProvider {
    static let weather = Weather(condition: .sunny, date: Date(), maxTemperature: 30, minTemperature: 10)
    static var previews: some View {
        WeatherWidgetEntryView(entry: SimpleEntry(date: Date(), weather: Self.weather, configuration: ConfigurationIntent()))
            .previewContext(WidgetPreviewContext(family: .systemSmall))
    }
}
