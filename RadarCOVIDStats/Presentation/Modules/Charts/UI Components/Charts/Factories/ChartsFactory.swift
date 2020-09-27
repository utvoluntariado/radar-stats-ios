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

        let xAxis = chartView.xAxis
        graphicFormatter.apply(format: .standard, to: xAxis)
        xAxis.valueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)

        let yAxis = chartView.leftAxis
        graphicFormatter.apply(format: .standard, to: yAxis)
        yAxis.valueFormatter = ChartAxisNumberFormatter()

        graphicFormatter.apply(format: .standard, to: chartView)
    }

    func drawSharedDiagnosesChart(using entries: [ChartDataEntry], xAxisLabelData: [TimeInterval], on chartView: BarChartView) {
        let chartDataSet = BarChartDataSet(entries: entries)
        chartDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
        chartDataSet.valueFormatter = ChartValueNumberFormatter()
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartView.data = chartData

        graphicFormatter.apply(gradient: .standard, to: chartDataSet)

        let xAxis = chartView.xAxis
        graphicFormatter.apply(format: .standard, to: xAxis)
        xAxis.valueFormatter = ChartAxisDateFormatter(dates: xAxisLabelData)

        let yAxis = chartView.leftAxis
        graphicFormatter.apply(format: .standard, to: yAxis)
        yAxis.valueFormatter = ChartAxisNumberFormatter()

        graphicFormatter.apply(format: .standard, to: chartView)
    }
}
