//
//  ChartsView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit

protocol ChartsView {
    var presenter: ChartsPresenter! { get set }

    func update(using stats: Stats)
}

class ChartsViewController: UIViewController, ChartsView {
    var presenter: ChartsPresenter!

    @IBOutlet private weak var summarySegmented: UISegmentedControl!
    @IBOutlet private weak var summaryStackView: SummaryStackView!
    @IBOutlet private weak var chartsTable: ChartsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        chartsTable.actionDelegate = self
        presenter.gatherStats()
    }

    func update(using stats: Stats) {
        chartsTable.update(modelset: stats)
    }

    @IBAction func didChangeSummarySegmented(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0: summaryStackView.prepareTodayMode()
        case 1: summaryStackView.prepareWeekMode()
        default: break
        }
    }
}

extension ChartsViewController: ChartsTableViewActionDelegate {
    func showInformationAbout(chartType: ChartType) {
        presenter.presentInfo(for: chartType)
    }
}
