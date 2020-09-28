//
//  SummaryView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 28/09/2020.
//

import UIKit

enum SummaryViewMode: String {
    case today
    case week
}

@IBDesignable
final class SummaryStackView: UIStackView {
    @IBOutlet private weak var uploadedTEKsStackView: UIStackView!
    @IBOutlet private weak var uploadedTEKsTitleLabel: UILabel!
    @IBOutlet private weak var uploadedTEKsValueLabel: UILabel!

    @IBOutlet private weak var sharedDiagnosesStackView: UIStackView!
    @IBOutlet private weak var sharedDiagnosesTitleLabel: UILabel!
    @IBOutlet private weak var sharedDiagnosesValueLabel: UILabel!

    @IBOutlet private weak var diagnosisTEKsStackView: UIStackView!
    @IBOutlet private weak var diagnosisTEKsTitleLabel: UILabel!
    @IBOutlet private weak var diagnosisTEKsValueLabel: UILabel!

    @IBOutlet private weak var usageRatioStackView: UIStackView!
    @IBOutlet private weak var usageRatioTitleLabel: UILabel!
    @IBOutlet private weak var usageRatioValueLabel: UILabel!

    @available(*, unavailable, message: "This property is reserved for Interface Builder. Use 'mode' instead.")
    @IBInspectable var modeName: String? {
        willSet {
            if let newMode = SummaryViewMode(rawValue: newValue?.lowercased() ?? "") {
                mode = newMode
            }
        }
    }

    var mode: SummaryViewMode = .today {
        didSet {
            switch mode {
            case .today: prepareTodayMode()
            case .week: prepareWeekMode()
            }
        }
    }

    private func prepareTodayMode() {
        addArrangedSubview(uploadedTEKsTitleLabel)
        addArrangedSubview(uploadedTEKsValueLabel)
        addArrangedSubview(diagnosisTEKsTitleLabel)
        addArrangedSubview(diagnosisTEKsValueLabel)
    }

    private func prepareWeekMode() {
        removeArrangedSubview(uploadedTEKsTitleLabel)
        removeArrangedSubview(uploadedTEKsValueLabel)
        removeArrangedSubview(diagnosisTEKsTitleLabel)
        removeArrangedSubview(diagnosisTEKsValueLabel)
    }
}
