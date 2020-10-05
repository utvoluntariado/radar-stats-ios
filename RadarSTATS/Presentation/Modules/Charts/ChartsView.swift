//
//  ChartsView.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import UIKit

protocol ChartsView: Loadable, Noticeable {
    var presenter: ChartsPresenter! { get set }

    func update(using localization: Localization)
    func update(using stats: Stats)
    func showCurrentData()
}

class ChartsViewController: UIViewController, ChartsView {
    var loadingView: UIView?

    var presenter: ChartsPresenter!

    @IBOutlet private weak var summarySegmented: UISegmentedControl!
    @IBOutlet private weak var summaryStackView: SummaryStackView!
    @IBOutlet private weak var chartsTable: ChartsTableView!

    private let refreshControl = UIRefreshControl()

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.viewDidLoad()
        presenter.gatherLocalization()
        chartsTable.actionDelegate = self
        chartsTable.refreshControl = refreshControl
        refreshControl.addTarget(self, action: #selector(refresh(_:)), for: .valueChanged)
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        chartsTable.alpha = 0.0
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        presenter.gatherStats(viewIsAlreadyShowingValues: chartsTable.modelset != nil)
    }

    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { _ in
            self.redrawSummaryStackView()
        }, completion: nil)
    }

    func update(using localization: Localization) {
        chartsTable.update(localization: localization.charts)
    }

    func update(using stats: Stats) {
        summarySegmented.setTitle("Hoy, \(stats.formattedExtrationDate(style: .medium))", forSegmentAt: 0)
        summaryStackView.update(using: stats)
        chartsTable.update(modelset: stats)
        showCurrentData()
    }

    func showCurrentData() {
        refreshControl.endRefreshing()
        UIView.animate(withDuration: 0.5) { self.chartsTable.alpha = 1.0 }
    }

    @objc func refresh(_ refreshControl: UIRefreshControl) {
        UIView.animate(withDuration: 0.5) {
            self.chartsTable.alpha = 0.0
        } completion: { (completed) in
            if completed {
                self.presenter.gatherStats(viewIsAlreadyShowingValues: self.chartsTable.modelset != nil)
            }
        }
    }

    @IBAction func didChangeSummarySegmented(_ sender: UISegmentedControl) {
        redrawSummaryStackView()
    }

    private func redrawSummaryStackView() {
        guard let summaryMode = SummaryMode(rawValue: summarySegmented.selectedSegmentIndex) else { return }
        summaryStackView.layout(mode: summaryMode)
    }
}

extension ChartsViewController: ChartsTableViewActionDelegate {
    func showInformationAbout(chartType: ChartType) {
        presenter.presentInfo(for: chartType)
    }

    func tableViewDidCompleteRefreshing(_ tableView: ChartsTableView) {
        refreshControl.endRefreshing()
    }
}
