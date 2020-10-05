//
//  LineChartFactory.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 26/09/2020.
//

import UIKit
import Charts

protocol ChartsFactory {
    var graphicFormatter: ChartGraphicFormatter! { get set }

    func drawLineChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView, with color: UIColor)
    func drawBarChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView, with color: UIColor, isPercent: Bool)
}

final class ChartsFactoryDefault: ChartsFactory {
    var graphicFormatter: ChartGraphicFormatter!

    func drawLineChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView, with color: UIColor) {
        let chartDataSet = LineChartDataSet(entries: entries.dropLast())
        chartDataSet.valueFormatter = ChartValueNumberFormatter()

        let lastValueChartDataSet = LineChartDataSet(entries: entries.suffix(2))
        lastValueChartDataSet.valueFormatter = ChartValueNumberFormatter()

        graphicFormatter.apply(format: .standard, to: chartDataSet, using: color)
        graphicFormatter.apply(format: .variable, to: lastValueChartDataSet, using: color)

        let chartData = LineChartData(dataSets: [chartDataSet, lastValueChartDataSet])
        chartView.data = chartData

        let xAxis = chartView.xAxis
        xAxis.spaceMin = 0.3
        xAxis.spaceMax = 0.3
        graphicFormatter.apply(format: .standard, to: xAxis)
        xAxis.valueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)

        let yAxis = chartView.leftAxis
        graphicFormatter.apply(format: .standard, to: yAxis)
        yAxis.valueFormatter = ChartAxisNumberFormatter()

        graphicFormatter.apply(format: .standard, to: chartView)
        chartView.setScaleEnabled(false)
    }

    func drawBarChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView, with color: UIColor, isPercent: Bool = false) {
        let chartDataSet = BarChartDataSet(entries: entries.dropLast())
        chartDataSet.valueFormatter = ChartValueNumberFormatter(percent: isPercent)

        let lastValueChartDataSet = BarChartDataSet(entries: entries.suffix(1))
        lastValueChartDataSet.valueFormatter = ChartValueNumberFormatter(percent: isPercent)
        
        let chartData = BarChartData(dataSets: [chartDataSet, lastValueChartDataSet])
        chartView.data = chartData

        graphicFormatter.apply(format: .standard, to: chartDataSet, using: color)
        graphicFormatter.apply(format: .variable, to: lastValueChartDataSet, using: color)

        let xAxis = chartView.xAxis
        graphicFormatter.apply(format: .standard, to: xAxis)
        xAxis.valueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)

        let yAxis = chartView.leftAxis
        graphicFormatter.apply(format: .standard, to: yAxis)
        yAxis.valueFormatter = ChartAxisNumberFormatter(percent: isPercent)

        graphicFormatter.apply(format: .standard, to: chartView)
        chartView.setScaleEnabled(false)
    }
}
