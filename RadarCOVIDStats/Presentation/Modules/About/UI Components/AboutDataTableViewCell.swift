//
//  AboutDataTableViewCell.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class AboutDataTableViewCell: UITableViewCell {
    static let reuseIndentifier = "AboutDataCell"

    @IBAction func didTapRadarCovidStatsDataButton(_ sender: UIButton) {
        guard let radarCovidStatsURL = URL(string: "https://github.com/pvieito/RadarCOVID-STATS") else { return }
        UIApplication.shared.open(radarCovidStatsURL)
    }

    @IBAction func didTapRadarCovidStatsiOSButton(_ sender: UIButton) {
        guard let radarCovidStatsiOSURL = URL(string: "https://github.com/jorgej-ramos/ios-radarcovid-stats") else { return }
        UIApplication.shared.open(radarCovidStatsiOSURL)
    }
}
