//
//  ChartValueFormatter.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import Foundation
import Charts

final class ChartValueNumberFormatter: IValueFormatter {
    private let numberFormatter = NumberFormatter()

    init(percent: Bool = false) {
        numberFormatter.usesGroupingSeparator = true
        numberFormatter.groupingSeparator = Locale.current.groupingSeparator
        
        if percent {
            numberFormatter.numberStyle = .percent
            numberFormatter.maximumFractionDigits = 2
        }
        else {
            numberFormatter.numberStyle = .decimal
            numberFormatter.allowsFloats = false
        }
    }

    func stringForValue(_ value: Double, entry: ChartDataEntry, dataSetIndex: Int, viewPortHandler: ViewPortHandler?) -> String {
        let number = NSNumber(value: value)
        return numberFormatter.string(from: number) ?? "NaN"
    }
}
