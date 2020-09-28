//
//  SummaryView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 28/09/2020.
//

import UIKit

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

    func prepareTodayMode() {
        addArrangedSubview(uploadedTEKsStackView)
        addArrangedSubview(diagnosisTEKsStackView)
        uploadedTEKsStackView.isHidden = false
        diagnosisTEKsStackView.isHidden = false
    }

    func prepareWeekMode() {
        removeArrangedSubview(uploadedTEKsStackView)
        removeArrangedSubview(diagnosisTEKsStackView)
        uploadedTEKsStackView.isHidden = true
        diagnosisTEKsStackView.isHidden = true
    }
}
