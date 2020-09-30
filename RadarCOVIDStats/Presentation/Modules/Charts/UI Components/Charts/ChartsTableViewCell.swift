//
//  ChartsTableViewCell.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import UIKit
import Charts

enum ChartType: Int {
    case covidCases
    case sharedDiagnoses
    case generationDateSharedTEKs
    case uploadDateSharedTEKs
    case uploadedTEKsPerSharedDiagnosis
    case unknown
}

protocol ChartsTableViewCellDelegate: class {
    func didTapInfoButton(on chartType: ChartType)
}

final class ChartsTableViewCell: UITableViewCell {
    static let reuseIndentifier = "ChartCell"

    weak var delegate: ChartsTableViewCellDelegate?

    private var modelset: Stats!
    private var chartType: ChartType!
    private let factory = <~ChartsFactory.self
    private var sortedDailyResults: [DailyStats] {
        return modelset.dailyResults.sorted(by: { $0.sampleDate < $1.sampleDate })
    }

    @IBOutlet private weak var chartTitleLabel: UILabel!
    @IBOutlet private weak var chartWrapperView: UIView!

    func bind(modelset: Stats, for chartType: ChartType) {
        self.modelset = modelset
        self.chartType = chartType

        switch chartType {
        case .covidCases: drawCovidCasesChart()
        case .sharedDiagnoses: drawSharedDiagnosesChart()
        case .generationDateSharedTEKs: drawGenerationDateSharedTEKsChart()
        case .uploadDateSharedTEKs: drawUploadDateSharedTEKsChart()
        case .uploadedTEKsPerSharedDiagnosis: drawUploadedTEKsPerSharedDiagnosisChart()
        case .unknown: break
        }
    }

    private func drawCovidCasesChart() {
        chartTitleLabel.text = "Casos COVID-19 (Estimados)"

        var dataEntries: [ChartDataEntry] = []
        for (index, day) in sortedDailyResults.enumerated() {
            let dataEntry = ChartDataEntry(x: Double(index), y: Double(day.covidCases))
            dataEntries.append(dataEntry)
        }
        
        drawLineChart(using: dataEntries, color: #colorLiteral(red: 0.5843137255, green: 0.6862745098, blue: 0.7529411765, alpha: 1))
    }

    private func drawSharedDiagnosesChart() {
        chartTitleLabel.text = "Diagnósticos compartidos (Estimados)"

        var dataEntries: [BarChartDataEntry] = []
        for (index, day) in sortedDailyResults.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index), y: Double(day.sharedDiagnoses))
            dataEntries.append(dataEntry)
        }

        drawBarChart(using: dataEntries, color: #colorLiteral(red: 0.7294117647, green: 0.862745098, blue: 0.3450980392, alpha: 1))
        layoutIfNeeded()
    }

    private func drawGenerationDateSharedTEKsChart() {
        chartTitleLabel.text = "TEKs compartidos por fecha de creación"

        var dataEntries: [BarChartDataEntry] = []
        for (index, day) in sortedDailyResults.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index), y: Double(day.sharedTeksByGenerationDate))
            dataEntries.append(dataEntry)
        }

        drawBarChart(using: dataEntries, color: #colorLiteral(red: 1, green: 0.7450980392, blue: 0.462745098, alpha: 1))
        layoutIfNeeded()
    }

    private func drawUploadDateSharedTEKsChart() {
        chartTitleLabel.text = "TEKs compartidos por fecha de subida"

        var dataEntries: [BarChartDataEntry] = []
        for (index, day) in sortedDailyResults.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index), y: Double(day.sharedTeksByUploadDate))
            dataEntries.append(dataEntry)
        }

        drawBarChart(using: dataEntries, color: #colorLiteral(red: 0.4941176471, green: 0.8392156863, blue: 0.8745098039, alpha: 1))
        layoutIfNeeded()
    }

    private func drawUploadedTEKsPerSharedDiagnosisChart() {
        chartTitleLabel.text = "TEKs compartidos por cada caso COVID"

        var dataEntries: [BarChartDataEntry] = []
        for (index, day) in sortedDailyResults.enumerated() {
            let dataEntry = BarChartDataEntry(x: Double(index), y: Double(day.sharedDiagnosesPerCovidCase))
            dataEntries.append(dataEntry)
        }

        drawBarChart(using: dataEntries, color: #colorLiteral(red: 0.9176470588, green: 0.5254901961, blue: 0.5215686275, alpha: 1))
        layoutIfNeeded()
    }

    private func drawLineChart(using entries: [ChartDataEntry], color: UIColor) {
        chartWrapperView.subviews.forEach { $0.removeFromSuperview() }

        let lineChartView = LineChartView()
        lineChartView.translatesAutoresizingMaskIntoConstraints = false
        chartWrapperView.addSubview(lineChartView)
        lineChartView.leadingAnchor.constraint(equalTo: chartWrapperView.leadingAnchor, constant: 8).isActive = true
        lineChartView.trailingAnchor.constraint(equalTo: chartWrapperView.trailingAnchor).isActive = true
        lineChartView.topAnchor.constraint(equalTo: chartWrapperView.topAnchor, constant: 16).isActive = true
        let bottomConstraint = lineChartView.bottomAnchor.constraint(equalTo: chartWrapperView.bottomAnchor, constant: -16)
        bottomConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomConstraint.isActive = true

        factory.drawLineChart(using: entries,
                              xAxisLabelData: sortedDailyResults.map { $0.sampleDate },
                              on: lineChartView,
                              with: color)
    }

    private func drawBarChart(using entries: [BarChartDataEntry], color: UIColor) {
        chartWrapperView.subviews.forEach { $0.removeFromSuperview() }

        let barChartView = BarChartView()
        barChartView.translatesAutoresizingMaskIntoConstraints = false
        chartWrapperView.addSubview(barChartView)
        barChartView.leadingAnchor.constraint(equalTo: chartWrapperView.leadingAnchor, constant: 8).isActive = true
        barChartView.trailingAnchor.constraint(equalTo: chartWrapperView.trailingAnchor).isActive = true
        barChartView.topAnchor.constraint(equalTo: chartWrapperView.topAnchor, constant: 16).isActive = true
        let bottomConstraint = barChartView.bottomAnchor.constraint(equalTo: chartWrapperView.bottomAnchor, constant: -16)
        bottomConstraint.priority = UILayoutPriority(rawValue: 999)
        bottomConstraint.isActive = true

        factory.drawBarChart(using: entries,
                             xAxisLabelData: sortedDailyResults.map { $0.sampleDate },
                             on: barChartView,
                             with: color)
    }

    func animateChart() {
        let chartView = chartWrapperView.subviews.compactMap({ $0 as? ChartViewBase }).first
        chartView?.animate(yAxisDuration: 1.0, easingOption: .easeInOutSine)
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        chartWrapperView.subviews.forEach { $0.removeFromSuperview() }
        chartTitleLabel.text = nil
    }

    @IBAction func didTapInfoButton(_ sender: UIButton) {
        delegate?.didTapInfoButton(on: chartType)
    }
}
