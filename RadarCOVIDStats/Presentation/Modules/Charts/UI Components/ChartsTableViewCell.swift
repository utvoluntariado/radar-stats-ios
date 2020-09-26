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
    private let factory = <~ChartsFactory.self
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

        factory.drawCovidCasesChart(using: dataEntries,
                                    xAxisLabelData: sortedDailyResults.map { $0.sampleDate },
                                    on: chartView)
    }

    private func drawSharedDiagnosesChart() {

    }
}
