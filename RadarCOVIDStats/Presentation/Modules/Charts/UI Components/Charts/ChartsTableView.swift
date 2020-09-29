//
//  ChartsTableView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit

protocol ChartsTableViewActionDelegate: class {
    func showInformationAbout(chartType: ChartType)
}

final class ChartsTableView: UITableView {
    weak var actionDelegate: ChartsTableViewActionDelegate?

    private var modelset: Stats?

    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
    }

    func update(modelset: Stats) {
        self.modelset = modelset
        reloadData()
    }
}

extension ChartsTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return modelset != nil ? 5 : 0
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let modelset = modelset else { return UITableViewCell() }
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartsTableViewCell.reuseIndentifier, for: indexPath) as! ChartsTableViewCell
        cell.bind(modelset: modelset, for: ChartType(rawValue: indexPath.row) ?? .unknown)
        cell.delegate = self
        return cell
    }

    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.layoutIfNeeded()
    }
}

extension ChartsTableView: ChartsTableViewCellDelegate {
    func didTapInfoButton(on chartType: ChartType) {
        actionDelegate?.showInformationAbout(chartType: chartType)
    }
}
