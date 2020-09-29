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
        return 1
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: AboutAuthorsTableViewCell.reuseIndentifier, for: indexPath) as! AboutAuthorsTableViewCell
        return cell
    }
}
