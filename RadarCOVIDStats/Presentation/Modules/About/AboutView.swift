//
//  AboutView.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

protocol AboutView {
    var presenter: AboutPresenter! { get set }
}

class AboutViewController: UIViewController, AboutView {
    var presenter: AboutPresenter!

    @IBOutlet private weak var aboutTable: AboutTableView!

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        aboutTable.reloadData()
    }
}
