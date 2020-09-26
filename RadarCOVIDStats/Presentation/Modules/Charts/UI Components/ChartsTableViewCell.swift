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
        for day in modelset.dailyResults.sorted(by: { $0.sampleDate < $1.sampleDate }) {
            let dataEntry = ChartDataEntry(x: day.sampleDate, y: Double(day.covidCases))
            dataEntries.append(dataEntry)
        }

        let chartDataSet = LineChartDataSet(entries: dataEntries)
        chartDataSet.fillColor = .red
        chartDataSet.drawFilledEnabled = true
        chartDataSet.mode = .horizontalBezier
        chartDataSet.circleRadius = 4
        chartDataSet.circleColors = [.red]
        chartDataSet.circleHoleRadius = 0
        chartDataSet.lineWidth = 2
        chartDataSet.colors = [.red]
        let chartData = LineChartData(dataSet: chartDataSet)

        let xAxis = chartView.xAxis
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.labelRotationAngle = 270
        xAxis.drawGridLinesEnabled = false
        xAxis.valueFormatter = LabelFormatter()

        chartView.data = chartData
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false
    }

    private func drawSharedDiagnosesChart() {

    }
}

class LabelFormatter: IAxisValueFormatter {
    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let date = Date(timeIntervalSince1970: value / 1000)
        let formatter = DateFormatter()
        formatter.locale = Locale.current
        formatter.dateFormat = "dd MMM"
        return formatter.string(from: date)
    }
}
