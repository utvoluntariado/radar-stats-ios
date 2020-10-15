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
        let entry = MetricsSummaryEntry(configuration: configuration, loadResults: true)

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
        } else {
            self.metricsSummary = IntentMetricsSummary.createEmptySummary()
        }
    }
}

struct MetricsSummaryWidgetEntryView : View {
    var entry: MetricsSummaryWidgetProvider.Entry
    
    var body: some View {
        let metrics = [
            (Text("SHARED_DIAGNOSES"), Text("≤ \(entry.metricsSummary.displaySharedDiagnoses)")),
            (Text("USAGE_RATIO"), Text("≤ \(entry.metricsSummary.displayUsageRatio)")),
            (Text("UPLOADED_TEKS"), Text(entry.metricsSummary.displayUploadedTEKs)),
        ]
        
        return GeometryReader { geometry in
            ZStack {
                LinearGradient(
                    gradient: Gradient(
                        colors: [
                            Color("WidgetGradientTopColor"),
                            Color("WidgetGradientBottomColor")]),
                    startPoint: .top, endPoint: .bottom)
                    .opacity(0.8)
                VStack(alignment: .leading) {
                    HStack(alignment: .top) {
                        VStack(alignment: .leading) {
                            Text("Radar STATS | \(entry.configuration.displayMetricsPeriod)")
                                .font(.title3).bold()
                            if let extractionDate = entry.metricsSummary.extractionDate {
                                Text(extractionDate, formatter: entry.metricsSummary.displayExtensionDateFormatter)
                                    .font(.system(size: 12))
                                    .bold()
                            }
                        }
                        Spacer()
                        Image("AppIconDisplay")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: geometry.size.width * 0.1)
                            .clipShape(ContainerRelativeShape(), style: FillStyle())
                            .shadow(radius: 2.0)
                    }
                    HStack(alignment: .bottom) {
                        VStack(alignment: .leading, spacing: 3) {
                            ForEach(0..<metrics.count) { i in
                                HStack() {
                                    metrics[i].0
                                        .font(.system(size: 15))
                                    Spacer()
                                    ZStack {
                                        Capsule()
                                            .foregroundColor(Color(.systemBackground))
                                        metrics[i].1
                                            .font(.system(size: 12))
                                            .bold()
                                    }
                                    .frame(width: geometry.size.width * 0.25)
                                }
                            }
                        }
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
        .configurationDisplayName("METRICS_SUMMARY_WIDGET_NAME")
        .description("METRICS_SUMMARY_WIDGET_DESCRIPTION")
        .supportedFamilies([.systemMedium])
    }
}

struct MetricsSummaryWidget_Previews: PreviewProvider {
    static var previews: some View {
        let configuration = GetMetricsSummaryIntent()
        let widgetView = MetricsSummaryWidgetEntryView(entry: MetricsSummaryEntry(configuration: configuration))
            .previewContext(WidgetPreviewContext(family: .systemMedium))

        return Group {
            widgetView.colorScheme(.light)
            widgetView.colorScheme(.dark)
        }
    }
}
