//
//  MainPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import Foundation

protocol MainPresenter {
    var view: MainView! { get set }
    var router: MainRouter! { get set }
    var statsInteractor: StatsInteractor! { get set }

    func gatherStats()
}

final class MainPresenterDefault: MainPresenter {
    var view: MainView!
    var router: MainRouter!

    var statsInteractor: StatsInteractor!

    func gatherStats() {
        statsInteractor.run().done { stats in
            
        }.catch { error in

        }
    }
}
