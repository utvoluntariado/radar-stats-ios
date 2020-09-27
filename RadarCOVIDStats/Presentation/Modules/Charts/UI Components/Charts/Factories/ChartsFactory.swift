//
//  LineChartFactory.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 26/09/2020.
//

import UIKit
import Charts

protocol ChartsFactory {
    var graphicFormatter: ChartGraphicFormatter! { get set }

    func drawCovidCasesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView)
    func drawSharedDiagnosesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView)
}

final class ChartsFactoryDefault: ChartsFactory {
    var graphicFormatter: ChartGraphicFormatter!

    func drawCovidCasesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView) {
        let chartDataSet = LineChartDataSet(entries: entries)
        chartDataSet.fillColor = #colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)
        chartDataSet.drawFilledEnabled = true
        chartDataSet.circleRadius = 8
        chartDataSet.circleColors = [#colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)]
        chartDataSet.circleHoleRadius = 4
        chartDataSet.lineWidth = 4
        chartDataSet.colors = [#colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)]
        chartDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        chartDataSet.valueFormatter = ChartValueNumberFormatter()

        graphicFormatter.apply(gradient: .standard, to: chartDataSet)

        let chartData = LineChartData(dataSet: chartDataSet)
        chartView.data = chartData

        let xAxisValueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)
        let xAxis = chartView.xAxis
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = xAxisValueFormatter
        xAxis.drawGridLinesEnabled = false
        xAxis.labelFont = UIFont.systemFont(ofSize: 10, weight: .semibold)

        let yAxisValueFormatter = ChartAxisNumberFormatter()
        let yAxis = chartView.leftAxis
        yAxis.valueFormatter = yAxisValueFormatter
        yAxis.labelXOffset = -4
        yAxis.labelFont = UIFont.systemFont(ofSize: 12, weight: .semibold)

        chartView.setVisibleXRangeMaximum(6)
        chartView.animate(yAxisDuration: 2.0, easingOption: .easeInOutSine)
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false

        chartView.notifyDataSetChanged()
        chartView.moveViewToX(xAxis.axisMaximum)
    }

    func drawSharedDiagnosesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView) {
        let chartDataSet = BarChartDataSet(entries: entries)
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData

        let xAxisValueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)
        let xAxis = chartView.xAxis
        xAxis.granularity = 1
        xAxis.granularityEnabled = true
        xAxis.labelPosition = .bottom
        xAxis.valueFormatter = xAxisValueFormatter
        xAxis.drawGridLinesEnabled = false

        let yAxisValueFormatter = ChartAxisNumberFormatter()
        let yAxis = chartView.leftAxis
        yAxis.valueFormatter = yAxisValueFormatter
        yAxis.labelXOffset = -4

        chartView.setVisibleXRangeMaximum(6)
        chartView.animate(yAxisDuration: 2.0, easingOption: .easeInOutSine)
        chartView.legend.enabled = false
        chartView.rightAxis.enabled = false

        chartView.notifyDataSetChanged()
        chartView.moveViewToX(xAxis.axisMaximum)
    }
}
