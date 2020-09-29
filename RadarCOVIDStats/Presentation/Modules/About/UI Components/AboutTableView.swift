//
//  AboutTableView.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class AboutTableView: UITableView {
    override func awakeFromNib() {
        super.awakeFromNib()
        delegate = self
        dataSource = self
    }
}

extension AboutTableView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.row {
        case 0: cell = tableView.dequeueReusableCell(withIdentifier: AboutAuthorsTableViewCell.reuseIndentifier, for: indexPath) as! AboutAuthorsTableViewCell
        case 1: cell = tableView.dequeueReusableCell(withIdentifier: AboutAppTableViewCell.reuseIndentifier, for: indexPath) as! AboutAppTableViewCell
        case 2: cell = tableView.dequeueReusableCell(withIdentifier: AboutDataTableViewCell.reuseIndentifier, for: indexPath) as! AboutDataTableViewCell
        case 3: cell = tableView.dequeueReusableCell(withIdentifier: AboutThirdPartiesTableViewCell.reuseIndentifier, for: indexPath) as! AboutThirdPartiesTableViewCell
        default: cell = UITableViewCell()
        }
        return cell
    }
}
