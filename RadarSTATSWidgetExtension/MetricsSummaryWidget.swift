//
//  MetricsSummaryWidget.swift
//  RadarSTATSWidgetExtension
//
//  Created by Pedro José Pereira Vieito on 2/10/20.
//

import SwiftUI
import WidgetKit
import Intents
import RadarSTATSIntents

struct MetricsSummaryWidgetProvider: IntentTimelineProvider {
    func placeholder(in context: Context) -> MetricsSummaryEntry {
        MetricsSummaryEntry(configuration: GetMetricsSummaryIntent())
    }

    func getSnapshot(for configuration: GetMetricsSummaryIntent, in context: Context, completion: @escaping (MetricsSummaryEntry) -> ()) {
        let entry = MetricsSummaryEntry(configuration: configuration)
        completion(entry)
    }

    func getTimeline(for configuration: GetMetricsSummaryIntent, in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
        let nextDate = Calendar.current.date(byAdding: .hour, value: 1, to: Date())!
        let entry = MetricsSummaryEntry(
            configuration: configuration, loadResults: true)

        let timeline = Timeline(entries: [entry], policy: .after(nextDate))
        completion(timeline)
    }
}

struct MetricsSummaryEntry: TimelineEntry {
    let date: Date
    let configuration: GetMetricsSummaryIntent
    let metricsSummary: IntentMetricsSummary
    
    init(configuration: GetMetricsSummaryIntent, loadResults: Bool = false) {
        self.date = Date()
        self.configuration = configuration
        if loadResults, let metricsSummary = try? configuration.loadMetricsSummary() {
            self.metricsSummary = metricsSummary
        }
        else {
            self.metricsSummary = IntentMetricsSummary.createEmptySummary()
        }
    }
}

struct MetricsSummaryWidgetEntryView : View {
    var entry: MetricsSummaryWidgetProvider.Entry
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color("WidgetGradientTopColor"),
                            Color("WidgetGradientBottomColor")]),
                    startPoint: .top, endPoint: .bottom)
                    .opacity(0.8)
                VStack(alignment: .leading) {
                    VStack(alignment: .leading) {
                        Text("Radar STATS | \(entry.configuration.displayMetricsPeriod)")
                            .font(.title3).bold()
                        if let extractionDate = entry.metricsSummary.extractionDate {
                            Text(extractionDate, formatter: entry.metricsSummary.displayExtensionDateFormatter)
                                .font(.footnote)
                                .bold()
                        }
                    }
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading) {
                            Text("Uploaded TEKs: \(entry.metricsSummary.displayUploadedTEKs)")
                            Text("Shared Diagnoses: ≤\(entry.metricsSummary.displaySharedDiagnoses)")
                            Text("Usage Ratio: ≤\(entry.metricsSummary.displayUsageRatio)")
                        }
                        .font(.callout)
                        Spacer()
                        Image("AppIconDisplay")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.15, height: nil)
                            .clipShape(ContainerRelativeShape(), style: FillStyle())
                    }
                }
                .padding()
            }
        }
    }
}

struct MetricsSummaryWidget: Widget {
    let kind: String = "MetricsSummaryWidget"

    var body: some WidgetConfiguration {
        IntentConfiguration(
            kind: kind, intent: GetMetricsSummaryIntent.self,
            provider: MetricsSummaryWidgetProvider()) { entry in
            MetricsSummaryWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Metrics Summary")
        .description("“Radar COVID” metrics summary.")
        .supportedFamilies([.systemMedium])
    }
}

struct MetricsSummaryWidget_Previews: PreviewProvider {
    static var previews: some View {
        let widgetView = MetricsSummaryWidgetEntryView(
            entry: MetricsSummaryEntry(configuration: GetMetricsSummaryIntent()))
            .previewContext(WidgetPreviewContext(family: .systemMedium))

        return Group {
            widgetView.colorScheme(.light)
            widgetView.colorScheme(.dark)
        }
    }
}
