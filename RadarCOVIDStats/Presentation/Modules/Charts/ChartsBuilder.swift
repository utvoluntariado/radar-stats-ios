//
//  ChartsBuilder.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 24/09/2020.
//

import UIKit

final class ChartsBuilder {
    static var build: Module {
        var view: ChartsView
        var viewController: UIViewController

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let thisViewController = storyboard.instantiateViewController(withIdentifier: "Charts") as! ChartsViewController
        viewController = thisViewController
        view = thisViewController as ChartsView

        let router = <~ChartsRouter.self
        router.viewController = thisViewController

        var presenter = <~ChartsPresenter.self
        presenter.view = view
        presenter.router = router
        presenter.statsInteractor = <~StatsInteractor.self

        view.presenter = presenter

        var module = Module(controller: viewController)
        module.router = router
        module.presenter = presenter
        module.view = view

        return module
    }
}

