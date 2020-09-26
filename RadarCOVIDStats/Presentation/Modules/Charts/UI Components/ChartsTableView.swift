//
//  ChartsTableView.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit

final class ChartsTableView: UITableView {
    private var modelset: Stats!

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
        return 3
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ChartsTableViewCell.reuseIndentifier, for: indexPath) as! ChartsTableViewCell
        cell.bind(modelset: modelset, for: ChartType(rawValue: indexPath.row) ?? .unknown)
        return cell
    }
}
