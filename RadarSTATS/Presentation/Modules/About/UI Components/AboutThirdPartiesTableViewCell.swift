//
//  AboutThirdPartiesTableViewCell.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class AboutThirdPartiesTableViewCell: UITableViewCell {
    static let reuseIndentifier = "AboutThirdPartiesCell"

    @IBAction func didTapSwinjectButton(_ sender: UIButton) {
        guard let swinjectURL = URL(string: "https://github.com/Swinject/Swinject") else { return }
        UIApplication.shared.open(swinjectURL)
    }

    @IBAction func didTapPromiseKitButton(_ sender: UIButton) {
        guard let promisekitURL = URL(string: "https://github.com/mxcl/PromiseKit") else { return }
        UIApplication.shared.open(promisekitURL)
    }

    @IBAction func didTapChartsButton(_ sender: UIButton) {
        guard let chartsURL = URL(string: "https://github.com/danielgindi/Charts") else { return }
        UIApplication.shared.open(chartsURL)
    }
}
