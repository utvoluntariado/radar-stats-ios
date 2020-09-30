//
//  AboutModule.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class AboutBuilder {
    static var build: Module {
        var view: AboutView
        var viewController: UIViewController

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let thisViewController = storyboard.instantiateViewController(withIdentifier: "About") as! AboutViewController
        viewController = thisViewController
        view = thisViewController as AboutView

        let router = <~AboutRouter.self
        router.viewController = thisViewController

        var presenter = <~AboutPresenter.self
        presenter.router = router
        presenter.view = view

        view.presenter = presenter

        var module = Module(controller: viewController)
        module.router = router
        module.presenter = presenter
        module.view = view

        return module
    }
}

