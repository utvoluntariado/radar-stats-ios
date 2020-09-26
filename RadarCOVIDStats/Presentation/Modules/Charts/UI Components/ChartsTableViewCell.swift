//
//  ChartsTableViewCell.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit
import Charts

enum ChartType: Int {
    case covidCases
    case sharedDiagnoses
    case unknown
}

final class ChartsTableViewCell: UITableViewCell {
    static let reuseIndentifier = "ChartCell"

    private var modelset: Stats!
    private var sortedDailyResults: [DailyStats] {
        return modelset.dailyResults.sorted(by: { $0.sampleDate < $1.sampleDate })
    }

    @IBOutlet weak var chartView: LineChartView!

    func bind(modelset: Stats, for chartType: ChartType) {
        self.modelset = modelset
        switch chartType {
        case .covidCases: drawCovidCasesChart()
        case .sharedDiagnoses: drawSharedDiagnosesChart()
        case .unknown: break
        }
    }

    private func drawCovidCasesChart() {
        var dataEntries: [ChartDataEntry] = []
        for (index, day) in sortedDailyResults.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: Double(day.covidCases))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(entries: dataEntries)
        chartDataSet.fillColor = .red
        chartDataSet.drawFilledEnabled = true
        chartDataSet.mode = .horizontalBezier
        chartDataSet.circleRadius = 8
        chartDataSet.circleColors = [.red]
        chartDataSet.circleHoleRadius = 4
        chartDataSet.lineWidth = 4
        chartDataSet.colors = [.red]

        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData

        let xAxisValueFormatter = DateAxisFormatter(dates: sortedDailyResults.map { $0.sampleDate })
        let xAxis = chartView.xAxis
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 60
        xAxis.valueFormatter = xAxisValueFormatter
        xAxis.drawGridLinesEnabled = false

        let yAxisValueFormatter = NumberAxisFormatter()
        let yAxis = chartView.leftAxis
        yAxis.valueFormatter = yAxisValueFormatter

        chartView.setVisibleXRangeMaximum(6)
        chartView.animate(yAxisDuration: 2.0, easingOption: .easeInOutSine)
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
    }

    private func drawSharedDiagnosesChart() {

    }
}

final class NumberAxisFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let number = NSNumber(value: value)
        let numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        numberFormatter.allowsFloats = false
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        return numberFormatter.string(from: number) ?? "NaN"
    }
}

final class DateAxisFormatter: IAxisValueFormatter {
    private let dates: [TimeInterval]

    init(dates: [TimeInterval]) {
        self.dates = dates
    }

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let timestamp = dates[Int(value)]
        let date = Date(timeIntervalSince1970: timestamp / 1000)
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateStyle = .short
        return formatter.string(from: date)
    }
}
