//
//  GraphicFormatter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit
import Charts

enum FillGradient {
    case standard
}

protocol ChartGraphicFormatter {
    func apply(gradient: FillGradient, to dataSet: IChartDataSet)
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
            
        }
    }
}

