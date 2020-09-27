//
//  ChartInfoPresenter.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import Foundation

protocol ChartInfoPresenter {
    var view: ChartInfoView! { get set }

    var chartType: ChartType! { get set }
}

final class ChartInfoPresenterDefault: ChartInfoPresenter {
    var view: ChartInfoView!

    var chartType: ChartType!
}

