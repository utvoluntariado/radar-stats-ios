//
//  GraphicFormatter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit
import Charts

enum AxisFormat {
    case standard
}

enum FillGradient {
    case standard
}

protocol ChartGraphicFormatter {
    func apply(gradient: FillGradient, to dataSet: IChartDataSet)
    func apply(format: AxisFormat, to axis: AxisBase)
}

struct ChartGraphicFormatterDefault: ChartGraphicFormatter {
    private let noGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[UIColor.clear.cgColor] as CFArray, locations: [1.0])!
    private let standardGradient = CGGradient(colorsSpace: CGColorSpaceCreateDeviceRGB(), colors:[#colorLiteral(red: 0.5529411765, green: 0.5019607843, blue: 0.6784313725, alpha: 1).cgColor, #colorLiteral(red: 0.5529411765, green: 0.5019607843, blue: 0.6784313725, alpha: 0.35).cgColor] as CFArray, locations: [1.0, 0.0])

    func apply(gradient: FillGradient, to dataSet: IChartDataSet) {
        let selectedGradient: CGGradient
        switch gradient {
        case .standard: selectedGradient = standardGradient ?? noGradient
        }

        if let currentDataSet = dataSet as? ILineChartDataSet {
            currentDataSet.fill = Fill.fillWithLinearGradient(selectedGradient, angle: 90.0)
        } else if let currentDataSet = dataSet as? BarChartDataSet {
            // TODO: Charts v4.0.0 will include gradients for bar charts
            currentDataSet.colors = [#colorLiteral(red: 0.4549019608, green: 0.5764705882, blue: 0.9294117647, alpha: 1)]
        }
    }

    func apply(format: AxisFormat, to axis: AxisBase) {
        axis.labelFont = UIFont.systemFont(ofSize: 12, weight: .semibold)
        if let xAxis = axis as? XAxis {
            xAxis.granularity = 1
            xAxis.granularityEnabled = true
            xAxis.labelPosition = .bottom
            xAxis.drawGridLinesEnabled = false
        } else if let yAxis = axis as? YAxis {
            yAxis.labelXOffset = -4
        }
    }
}

