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

    @IBAction func didTapRadarCovidStatsDataButton(_ sender: UIButton) {
        guard let radarCovidStatsURL = URL(string: "https://github.com/Radar-STATS/Radar-STATS") else { return }
        UIApplication.shared.open(radarCovidStatsURL)
    }

    @IBAction func didTapRadarCovidStatsiOSButton(_ sender: UIButton) {
        guard let radarCovidStatsiOSURL = URL(string: "https://github.com/Radar-STATS/Radar-STATS-iOS") else { return }
        UIApplication.shared.open(radarCovidStatsiOSURL)
    }
}
