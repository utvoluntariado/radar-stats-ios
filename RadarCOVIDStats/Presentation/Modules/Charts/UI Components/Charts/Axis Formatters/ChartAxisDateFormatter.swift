//
//  DateAxisFormatter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 26/09/2020.
//

import Foundation
import Charts

final class ChartAxisDateFormatter: IAxisValueFormatter {
    private let dates: [TimeInterval]
    private let formatter = DateFormatter()

    init(dates: [TimeInterval]) {
        self.dates = dates
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMM"
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let index = Int(value)
        guard index < dates.count else {
            return ""
        }
        let timestamp = dates[index]
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        return formatter.string(from: date)
    }
}
