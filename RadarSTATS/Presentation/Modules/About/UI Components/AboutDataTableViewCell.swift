//
//  AboutDataTableViewCell.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class AboutDataTableViewCell: UITableViewCell {
    static let reuseIndentifier = "AboutDataCell"

    @IBAction func didTapRadarStatsDataButton(_ sender: UIButton) {
        guard let radarStatsURL = URL(string: "https://github.com/Radar-STATS/Radar-STATS") else { return }
        UIApplication.shared.open(radarStatsURL)
    }

    @IBAction func didTapRadarStatsiOSButton(_ sender: UIButton) {
        guard let radarStatsiOSURL = URL(string: "https://github.com/Radar-STATS/Radar-STATS-iOS") else { return }
        UIApplication.shared.open(radarStatsiOSURL)
    }
}
