//
//  GraphicFormatter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit
import Charts

enum ChartFormat {
    case standard
}

enum AxisFormat {
    case standard
}

enum DataSetFormat {
    case standard
}

protocol ChartGraphicFormatter {
    func apply(format: DataSetFormat, to dataSet: IChartDataSet, using color: UIColor)
    func apply(format: AxisFormat, to axis: AxisBase)
    func apply(format: ChartFormat, to chartView: ChartViewBase)
}

struct ChartGraphicFormatterDefault: ChartGraphicFormatter {
    private let noGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[UIColor.clear.cgColor] as CFArray, locations: [1.0])!
    private let valueFontColor = UIColor(named: "chartValuesFontForeground")! // Current Charts version doesn't support modern color asset expression for font colors

    func apply(format: DataSetFormat, to dataSet: IChartDataSet, using color: UIColor) {
        if let lineChartDataSet = dataSet as? LineChartDataSet {
            lineChartDataSet.circleRadius = 8
            lineChartDataSet.circleColors = [color]
            lineChartDataSet.circleHoleRadius = 4
            lineChartDataSet.lineWidth = 4
            lineChartDataSet.colors = [color]
            lineChartDataSet.drawFilledEnabled = true
            lineChartDataSet.highlightEnabled = false

            let gradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[color.cgColor, color.withAlphaComponent(0.4).cgColor] as CFArray, locations: [1.0, 0.0])
            lineChartDataSet.fill = Fill.fillWithLinearGradient(gradient ?? noGradient, angle: 90.0)

            lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
            lineChartDataSet.valueColors = [valueFontColor]
        } else if let barChartDataSet = dataSet as? BarChartDataSet {
            // TODO: Charts v4.0.0 will include gradients for bar charts
            barChartDataSet.colors = [color]
            barChartDataSet.valueColors = [valueFontColor]
            barChartDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
            barChartDataSet.highlightEnabled = false
        }
    }

    func apply(format: AxisFormat, to axis: AxisBase) {
        axis.labelFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        if let xAxis = axis as? XAxis {
            xAxis.granularity = 1
            xAxis.granularityEnabled = true
            xAxis.labelPosition = .bottom
            xAxis.drawGridLinesEnabled = false
            xAxis.labelTextColor = valueFontColor
        } else if let yAxis = axis as? YAxis {
            yAxis.labelXOffset = -4
            yAxis.drawGridLinesEnabled = false
            yAxis.labelTextColor = valueFontColor
        }
    }

    func apply(format: ChartFormat, to chartView: ChartViewBase) {
        switch format {
        case .standard: applyStandardFormat(on: chartView)
        }
    }

    private func applyStandardFormat(on chartView: ChartViewBase) {
        chartView.animate(yAxisDuration: 0.8, easingOption: .easeInOutSine)
        chartView.legend.enabled = false
        chartView.notifyDataSetChanged()

        if let barChartView = chartView as? BarChartView {
            barChartView.setVisibleXRangeMaximum(6)
            barChartView.rightAxis.enabled = false
            barChartView.moveViewToX(barChartView.xAxis.axisMaximum)
        } else if let lineChartView = chartView as? LineChartView {
            lineChartView.setVisibleXRangeMaximum(5)
            lineChartView.rightAxis.enabled = false
            lineChartView.moveViewToX(lineChartView.xAxis.axisMaximum)
        }
    }
}

