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

    func drawLineChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView, with color: UIColor)
    func drawBarChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView, with color: UIColor)
}

final class ChartsFactoryDefault: ChartsFactory {
    var graphicFormatter: ChartGraphicFormatter!

    func drawLineChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: LineChartView, with color: UIColor) {
        let chartDataSet = LineChartDataSet(entries: entries)
        chartDataSet.valueFormatter = ChartValueNumberFormatter()

        graphicFormatter.apply(format: .standard, to: chartDataSet, using: color)

        let chartData = LineChartData(dataSet: chartDataSet)
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
    }

    func drawBarChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView, with color: UIColor) {
        let chartDataSet = BarChartDataSet(entries: entries)
        chartDataSet.valueFormatter = ChartValueNumberFormatter()
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData

        graphicFormatter.apply(format: .standard, to: chartDataSet, using: color)

        let xAxis = chartView.xAxis
        graphicFormatter.apply(format: .standard, to: xAxis)
        xAxis.valueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)

        let yAxis = chartView.leftAxis
        graphicFormatter.apply(format: .standard, to: yAxis)
        yAxis.valueFormatter = ChartAxisNumberFormatter()

        graphicFormatter.apply(format: .standard, to: chartView)
    }
}
