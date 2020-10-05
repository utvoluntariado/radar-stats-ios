//
//  GraphicFormatter.swift
//  RadarSTATS
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
    case variable
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
            lineChartDataSet.mode = .cubicBezier
            lineChartDataSet.cubicIntensity = 0.3
            if format == .variable {
                lineChartDataSet.lineCapType = .round
                lineChartDataSet.lineDashLengths = [2, 6]
            }

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
            if format == .variable {
                barChartDataSet.barBorderWidth = 2
                barChartDataSet.barBorderColor = color
                barChartDataSet.colors = [UIColor.clear]
            }
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
        chartView.legend.enabled = false
        chartView.notifyDataSetChanged()

        if let barChartView = chartView as? BarChartView {
            barChartView.setVisibleXRangeMaximum(estimatedVisibleXRangeForBarChartView())
            barChartView.rightAxis.enabled = false
            barChartView.moveViewToX(barChartView.xAxis.axisMaximum)
        } else if let lineChartView = chartView as? LineChartView {
            lineChartView.setVisibleXRangeMaximum(estimatedVisibleXRangeForLineChartView())
            lineChartView.rightAxis.enabled = false
            lineChartView.moveViewToX(lineChartView.xAxis.axisMaximum)
        }
    }

    private func estimatedVisibleXRangeForBarChartView() -> Double {
        if UIDevice.current.userInterfaceIdiom == .phone {
            switch UIDevice.current.orientation {
            case .landscapeLeft, .landscapeRight: return 5 
            default: return 6
            }
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            switch UIDevice.current.orientation {
            case .landscapeLeft, .landscapeRight: return 10
            default: return 6
            }
        } else if #available(iOS 14.0, *), UIDevice.current.userInterfaceIdiom == .mac {
            return 14
        } else {
            return 6
        }
    }

    private func estimatedVisibleXRangeForLineChartView() -> Double {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return 5
        } else if UIDevice.current.userInterfaceIdiom == .pad {
            switch UIDevice.current.orientation {
            case .landscapeLeft, .landscapeRight: return 8
            default: return 6
            }
        } else if #available(iOS 14.0, *), UIDevice.current.userInterfaceIdiom == .mac {
            return 14
        } else {
            return 5
        }
    }
}

