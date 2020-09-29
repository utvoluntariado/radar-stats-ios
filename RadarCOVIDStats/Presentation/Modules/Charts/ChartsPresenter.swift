//
//  ChartsPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

protocol ChartsPresenter {
    var view: ChartsView! { get set }
    var router: ChartsRouter! { get set }
    var statsInteractor: StatsInteractor! { get set }

    func gatherStats()
    func presentInfo(for chartType: ChartType)
}

final class ChartsPresenterDefault: ChartsPresenter {
    var view: ChartsView!
    var router: ChartsRouter!

    var statsInteractor: StatsInteractor!

    func gatherStats() {
        view.showLoading()
        statsInteractor.run().done { stats in
            self.view.hideLoading { self.view.update(using: stats) }
        }.catch { error in
            print(error)
        }
    }

    func presentInfo(for chartType: ChartType) {
        router.navigate(to: .info(chartType: chartType))
    }
}
