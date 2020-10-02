//
//  AboutTableViewCell.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class AboutAuthorsTableViewCell: UITableViewCell {
    static let reuseIndentifier = "AboutAuthorsCell"


    @IBAction func didTapJJRGTwitterButton(_ sender: UIButton) {
        guard let promisekitURL = URL(string: "https://twitter.com/YoryoBass") else { return }
        UIApplication.shared.open(promisekitURL)
    }

    @IBAction func didTapJJRGGitHubButton(_ sender: UIButton) {
        guard let promisekitURL = URL(string: "https://github.com/jorgej-ramos") else { return }
        UIApplication.shared.open(promisekitURL)
    }

    @IBAction func didTapPJPVTwitterButton(_ sender: UIButton) {
        guard let promisekitURL = URL(string: "https://twitter.com/pvieito") else { return }
        UIApplication.shared.open(promisekitURL)
    }

    @IBAction func didTapPJPVGitHubButton(_ sender: UIButton) {
        guard let promisekitURL = URL(string: "https://github.com/pvieito") else { return }
        UIApplication.shared.open(promisekitURL)
    }
}
