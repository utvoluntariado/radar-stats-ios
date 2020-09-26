//
//  LineChartFactory.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 26/09/2020.
//

import Foundation
import Charts

protocol ChartsFactory {
    func drawCovidCasesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView)
}

final class ChartsFactoryDefault: ChartsFactory {
    func drawCovidCasesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView) {
        let chartDataSet = LineChartDataSet(entries: entries)
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

        let xAxisValueFormatter = DateAxisFormatter(dates: xAxisLabelData)
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
}
