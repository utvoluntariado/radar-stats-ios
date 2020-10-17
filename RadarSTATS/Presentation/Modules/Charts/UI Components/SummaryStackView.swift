//
//  SummaryView.swift
//  RadarSTATS
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
    private(set) var mode: SummaryMode = .today

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
        switch mode {
        case .today: updateTodayStats()
        case .week: updateWeekStats()
        }
    }

    func layout(mode: SummaryMode) {
        guard self.stats != nil else {
            return
        }
        
        switch mode {
        case .today:
            updateTodayStats()
            layoutTodayMode()
        case .week:
            updateWeekStats()
            layoutWeekMode()
        }
    }

    private func updateTodayStats() {
        UIView.animate(withDuration: 0.35, delay: 0.0, options: .curveEaseInOut) {
            self.uploadedTEKsValueLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.sharedDiagnosesValueLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.diagnosisTEKsValueLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.usageRatioValueLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        } completion: { (completed) in
            if completed {
                self.uploadedTEKsValueLabel.text = "\(self.stats.today.sharedTeksByUploadDate)"
                self.sharedDiagnosesValueLabel.text = "≤ \(self.stats.today.sharedDiagnoses)"
                self.diagnosisTEKsValueLabel.text = "≥ \(self.stats.today.formattedTeksPerSharedDiagnosis())"
                self.usageRatioValueLabel.text = "≤ \(self.stats.today.formattedUsageRatio())"

                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                    self.uploadedTEKsValueLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.sharedDiagnosesValueLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.diagnosisTEKsValueLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.usageRatioValueLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }

    private func layoutTodayMode() {
        UIView.animate(withDuration: 0.35) {
            self.uploadedTEKsStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
            self.diagnosisTEKsStackView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
        } completion: { (completed) in
            if completed && UIDevice.current.orientation == .portrait {
                UIView.animate(withDuration: 0.25) {
                    self.uploadedTEKsStackView.isHidden = false
                    self.diagnosisTEKsStackView.isHidden = false
                }
            }
        }
    }

    private func updateWeekStats() {
        UIView.animate(withDuration: 0.25, delay: 0.0, options: .curveEaseInOut) {
            self.sharedDiagnosesValueLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.usageRatioValueLabel.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        } completion: { (completed) in
            if completed {
                self.sharedDiagnosesValueLabel.text = "≤ \(self.stats.last7Days.sharedDiagnoses)"
                self.usageRatioValueLabel.text = "≤ \(self.stats.last7Days.formattedUsageRatio())"

                UIView.animate(withDuration: 0.7, delay: 0, usingSpringWithDamping: 0.8, initialSpringVelocity: 2, options: .curveEaseInOut, animations: {
                    self.sharedDiagnosesValueLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                    self.usageRatioValueLabel.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
                }, completion: nil)
            }
        }
    }

    private func layoutWeekMode() {
        UIView.animate(withDuration: 0.35) {
            self.uploadedTEKsStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
            self.diagnosisTEKsStackView.transform = CGAffineTransform(scaleX: 0.0, y: 0.0)
        } completion: { (completed) in
            if completed && UIDevice.current.orientation == .portrait {
                UIView.animate(withDuration: 0.25) {
                    self.uploadedTEKsStackView.isHidden = true
                    self.diagnosisTEKsStackView.isHidden = true
                }
            } else if completed && UIDevice.current.orientation == .landscapeLeft || UIDevice.current.orientation == .landscapeRight   {
                UIView.animate(withDuration: 0.25) {
                    self.uploadedTEKsStackView.isHidden = false
                    self.diagnosisTEKsStackView.isHidden = false
                }
            }
        }
    }
}
