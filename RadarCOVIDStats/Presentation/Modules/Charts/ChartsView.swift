//
//  ChartsView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import UIKit

protocol ChartsView: Loadable, Noticeable {
    var presenter: ChartsPresenter! { get set }

    func update(using stats: Stats)
}

class ChartsViewController: UIViewController, ChartsView {
    var loadingView: UIView?

    var presenter: ChartsPresenter!

    @IBOutlet private weak var summarySegmented: UISegmentedControl!
    @IBOutlet private weak var summaryStackView: SummaryStackView!
    @IBOutlet private weak var chartsTable: ChartsTableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        chartsTable.actionDelegate = self
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.gatherStats()
    }

    func update(using stats: Stats) {
        summarySegmented.setTitle("Hoy, \(stats.formattedExtrationDate(style: .medium))", forSegmentAt: 0)
        summaryStackView.update(using: stats)
        chartsTable.update(modelset: stats)
    }

    @IBAction func didChangeSummarySegmented(_ sender: UISegmentedControl) {
        guard let summaryMode = SummaryMode(rawValue: sender.selectedSegmentIndex) else { return }
        summaryStackView.layout(mode: summaryMode)
    }
}

extension ChartsViewController: ChartsTableViewActionDelegate {
    func showInformationAbout(chartType: ChartType) {
        presenter.presentInfo(for: chartType)
    }
}
