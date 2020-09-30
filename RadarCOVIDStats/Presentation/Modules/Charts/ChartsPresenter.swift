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
    var networkService: NetworkService! { get set }

    func viewDidLoad()
    func gatherStats()
    func presentInfo(for chartType: ChartType)
}

class ChartsPresenterDefault: ChartsPresenter {
    var view: ChartsView!
    var router: ChartsRouter!

    var statsInteractor: StatsInteractor!
    var networkService: NetworkService!

    func viewDidLoad() {
        networkService.delegate += self
    }

    func gatherStats() {
        view.showLoading()
        statsInteractor.run().done { stats in
            self.view.hideLoading { self.view.update(using: stats) }
        }.catch { error in
            self.show(error: error)
        }
    }

    func presentInfo(for chartType: ChartType) {
        router.navigate(to: .info(chartType: chartType))
    }

    internal func show(error: Error) {
        view.hideLoading { self.view.show(error: error) }
    }
}

extension ChartsPresenterDefault: NetworkServiceMulticastDelegate {
    func networkService(_ service: NetworkService, didChangeReachability reachable: Bool) {
        if !reachable {
            view.show(error: NetworkError.notReachable)
        }
    }
}
