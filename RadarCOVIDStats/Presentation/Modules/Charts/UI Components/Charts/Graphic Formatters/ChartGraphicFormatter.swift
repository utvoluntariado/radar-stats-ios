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
    func apply(format: DataSetFormat, to dataSet: IChartDataSet)
    func apply(format: AxisFormat, to axis: AxisBase)
    func apply(format: ChartFormat, to chartView: ChartViewBase)
}

struct ChartGraphicFormatterDefault: ChartGraphicFormatter {
    private let noGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[UIColor.clear.cgColor] as CFArray, locations: [1.0])!
    private let standardGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[#colorLiteral(red: 0.5529411765, green: 0.5019607843, blue: 0.6784313725, alpha: 1).cgColor, #colorLiteral(red: 0.5529411765, green: 0.5019607843, blue: 0.6784313725, alpha: 0.35).cgColor] as CFArray, locations: [1.0, 0.0])
    private let valueFontColor = UIColor(named: "chartValuesFontForeground")! // Current Charts version doesn't support modern color asset expression for font colors

    func apply(format: DataSetFormat, to dataSet: IChartDataSet) {
        let selectedGradient: CGGradient
        switch format {
        case .standard: selectedGradient = standardGradient ?? noGradient
        }

        if let lineChartDataSet = dataSet as? LineChartDataSet {
            lineChartDataSet.circleRadius = 8
            lineChartDataSet.circleColors = [#colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)]
            lineChartDataSet.circleHoleRadius = 4
            lineChartDataSet.lineWidth = 4
            lineChartDataSet.colors = [#colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)]
            lineChartDataSet.drawFilledEnabled = true
            lineChartDataSet.fill = Fill.fillWithLinearGradient(selectedGradient, angle: 90.0)
            lineChartDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
            lineChartDataSet.valueColors = [valueFontColor]
        } else if let barChartDataSet = dataSet as? BarChartDataSet {
            // TODO: Charts v4.0.0 will include gradients for bar charts
            barChartDataSet.colors = [#colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)]
            barChartDataSet.valueColors = [valueFontColor]
            barChartDataSet.valueFont = UIFont.systemFont(ofSize: 10, weight: .semibold)
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
        chartView.animate(yAxisDuration: 2.0, easingOption: .easeInOutSine)
        chartView.legend.enabled = false
        chartView.notifyDataSetChanged()

        if let barLineChartView = chartView as? BarLineChartViewBase {
            barLineChartView.setVisibleXRangeMaximum(5)
            barLineChartView.rightAxis.enabled = false
            barLineChartView.moveViewToX(barLineChartView.xAxis.axisMaximum)
        }
    }
}

