//
//  SummaryView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 28/09/2020.
//

import UIKit

enum SummaryMode: Int {
    case today
    case week
}

@IBDesignable
final class SummaryStackView: UIStackView {
    private var stats: Stats!

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

    func update(using stats: Stats) {
        self.stats = stats
    }

    func layout(mode: SummaryMode) {
        switch mode {
        case .today:
            layoutTodayMode()
        case .week:
            layoutWeekMode()
        }
    }

    private func layoutTodayMode() {
        UIView.animate(withDuration: 0.35) {
            self.uploadedTEKsStackView.isHidden = false
            self.diagnosisTEKsStackView.isHidden = false
            self.uploadedTEKsStackView.alpha = 1.0
            self.diagnosisTEKsStackView.alpha = 1.0
        }
    }

    private func layoutWeekMode() {
        UIView.animate(withDuration: 0.35) {
            self.uploadedTEKsStackView.isHidden = true
            self.diagnosisTEKsStackView.isHidden = true
            self.uploadedTEKsStackView.alpha = 0.0
            self.diagnosisTEKsStackView.alpha = 0.0
        }
    }
}
