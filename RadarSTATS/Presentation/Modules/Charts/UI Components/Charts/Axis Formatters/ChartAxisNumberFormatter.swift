//
//  NumberAxisFormatter.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 26/09/2020.
//

import Foundation
import Charts

final class ChartAxisNumberFormatter: IAxisValueFormatter {
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

    func stringForValue(_ value: Double, axis: AxisBase?) -> String {
        let number = NSNumber(value: value)
        return numberFormatter.string(from: number) ?? "NaN"
    }
}
