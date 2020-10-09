//
//  ChartsTableView.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import UIKit

protocol ChartsTableViewActionDelegate: class {
    func showInformationAbout(chartType: ChartType)
    func tableViewDidCompleteRefreshing(_ tableView: ChartsTableView)
}

final class ChartsTableView: UITableView {
    weak var actionDelegate: ChartsTableViewActionDelegate?

    private var alreadyAnimatedChartCellsIndexPaths = [IndexPath]()
    private(set) var modelset: Stats?
    private var localization = [LocalizationItem]()

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
    }

    func update(localization: [LocalizationItem]) {
        self.localization = localization
    }

    func update(modelset: Stats) {
        self.modelset = modelset
        reloadData()
        actionDelegate?.tableViewDidCompleteRefreshing(self)
    }
}

extension ChartsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelset != nil ? 5 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelset = modelset else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartsTableViewCell.reuseIndentifier, for: indexPath) as! ChartsTableViewCell
        cell.bind(modelset: modelset, localization: localization[indexPath.row], for: ChartType(rawValue: indexPath.row) ?? .unknown)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        if !alreadyAnimatedChartCellsIndexPaths.contains(indexPath), let chartCell = cell as? ChartsTableViewCell {
            alreadyAnimatedChartCellsIndexPaths.append(indexPath)
            chartCell.animateChart()
        }
    }
}

extension ChartsTableView: ChartsTableViewCellDelegate {
    func didTapInfoButton(on chartType: ChartType) {
        actionDelegate?.showInformationAbout(chartType: chartType)
    }
}
