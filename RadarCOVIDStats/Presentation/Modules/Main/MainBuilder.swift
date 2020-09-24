//
//  MainBuilder.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import UIKit

final class MainBuilder {
    static var build: Module {
        var view: MainView
        var viewController: UIViewController

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let thisViewController = storyboard.instantiateViewController(withIdentifier: "Main") as! MainViewController
        viewController = thisViewController
        view = thisViewController as MainView

        var router = <~MainRouter.self
        router.viewController = (view as! MainViewController)

        var presenter = <~MainPresenter.self
        presenter.router = router
        presenter.view = view
        presenter.statsInteractor = <~StatsInteractor.self

        view.presenter = presenter

        var module = Module(controller: viewController)
        module.router = router
        module.presenter = presenter
        module.view = view

        return module
    }
}

