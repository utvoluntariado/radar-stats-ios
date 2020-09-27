//
//  ChartsPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import Foundation

protocol ChartsPresenter {
    var view: ChartsView! { get set }
    var router: ChartsRouter! { get set }
    var statsInteractor: StatsInteractor! { get set }

    func gatherStats()
}

final class ChartsPresenterDefault: ChartsPresenter {
    var view: ChartsView!
    var router: ChartsRouter!

    var statsInteractor: StatsInteractor!

    func gatherStats() {
        statsInteractor.run().done { stats in
            self.view.update(using: stats)
        }.catch { error in
            print(error)
        }
    }
}
