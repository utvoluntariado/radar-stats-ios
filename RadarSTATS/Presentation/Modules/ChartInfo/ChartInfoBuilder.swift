//
//  ChartInfoBuilder.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit

final class ChartInfoBuilder {
    static func build(chartType: ChartType) -> Module {
        var view: ChartInfoView
        var viewController: UIViewController

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let thisViewController = storyboard.instantiateViewController(withIdentifier: "ChartInfo") as! ChartInfoViewController
        viewController = thisViewController
        view = thisViewController as ChartInfoView

        let router = <~ChartInfoRouter.self
        router.viewController = thisViewController

        var presenter = <~ChartInfoPresenter.self
        presenter.router = router
        presenter.view = view
        presenter.chartType = chartType

        view.presenter = presenter

        var module = Module(controller: viewController)
        module.router = router
        module.presenter = presenter
        module.view = view

        return module
    }
}
