//
//  ChartInfoPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import Foundation

protocol ChartInfoPresenter {
    var router: ChartInfoRouter! { get set }
    var view: ChartInfoView! { get set }

    var chartType: ChartType! { get set }

    func dismiss()
}

final class ChartInfoPresenterDefault: ChartInfoPresenter {
    var router: ChartInfoRouter!
    var view: ChartInfoView!

    var chartType: ChartType!

    func dismiss() {
        router.navigate(to: .dismiss)
    }
}

