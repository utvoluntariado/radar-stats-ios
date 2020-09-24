//
//  AppDelegate.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit

protocol ChartsView {
    var presenter: ChartsPresenter! { get set }
}

class ChartsViewController: UIViewController, ChartsView {
    var presenter: ChartsPresenter!

    @IBOutlet private weak var chartsTable: ChartsTableView!
}
