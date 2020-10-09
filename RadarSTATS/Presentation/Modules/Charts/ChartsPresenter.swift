//
//  ChartsPresenter.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation

protocol ChartsPresenter {
    var view: ChartsView! { get set }
    var router: ChartsRouter! { get set }
    var statsInteractor: StatsInteractor! { get set }
    var localizationInteractor: LocalizationInteractor! { get set }
    var networkService: NetworkService! { get set }

    func viewDidLoad()
    func gatherLocalization()
    func gatherStats(viewIsAlreadyShowingValues: Bool)
    func presentInfo(for chartType: ChartType)
}

class ChartsPresenterDefault: ChartsPresenter {
    var view: ChartsView!
    var router: ChartsRouter!

    var statsInteractor: StatsInteractor!
    var localizationInteractor: LocalizationInteractor!
    var networkService: NetworkService!

    private var localization: Localization!

    func viewDidLoad() {
        networkService.delegate += self
    }

    func gatherLocalization() {
        localizationInteractor.run().done { localization in
            self.localization = localization
            self.updateTable(using: localization)
        }.catch { error in
            self.show(error: error)
        }
    }

    func gatherStats(viewIsAlreadyShowingValues: Bool) {
        view.showLoading()
        statsInteractor.run().done { result in
            if result.shouldForceUpdate || !viewIsAlreadyShowingValues {
                self.updateView(using: result.stats)
            } else {
                self.showCurrentData()
            }
        }.catch { error in
            self.alert(with: error)
        }
    }

    func presentInfo(for chartType: ChartType) {
        router.navigate(to: .info(chartType: chartType))
    }

    internal func showCurrentData() {
        self.view.hideLoading { self.view.showCurrentData() }
    }

    internal func updateTable(using localization: Localization) {
        view.update(using: localization)
    }

    internal func updateView(using stats: Stats) {
        view.hideLoading { self.view.update(using: stats) }
    }

    internal func show(error: Error) {
        view.hideLoading { self.view.show(error: error) }
    }

    internal func alert(with error: Error) {
        view.hideLoading { self.view.alert(using: error) }
    }
}

extension ChartsPresenterDefault: NetworkServiceMulticastDelegate {
    func networkService(_ service: NetworkService, didChangeReachability reachable: Bool) {
        if !reachable {
            view.show(error: NetworkError.notReachable)
        }
    }
}
