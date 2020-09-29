//
//  AboutPresenter.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import Foundation

protocol AboutPresenter {
    var router: AboutRouter! { get set }
    var view: AboutView! { get set }

    var chartType: ChartType! { get set }

    func dismiss()
}

final class AboutPresenterDefault: AboutPresenter {
    var router: AboutRouter!
    var view: AboutView!

    var chartType: ChartType!

    func dismiss() {
        router.navigate(to: .dismiss)
    }
}
