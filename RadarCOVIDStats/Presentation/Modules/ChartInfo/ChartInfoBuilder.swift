//
//  ChartInfoBuilder.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit

final class ChartInfoBuilder {
    static var build: Module {
        var view: ChartInfoView
        var viewController: UIViewController

        let storyboard = UIStoryboard(name: "Main", bundle: Bundle(for: self))
        let thisViewController = storyboard.instantiateViewController(withIdentifier: "ChartInfo") as! ChartInfoViewController
        viewController = thisViewController
        view = thisViewController as ChartInfoView

        var presenter = <~ChartInfoPresenter.self
        presenter.view = view

        view.presenter = presenter

        var module = Module(controller: viewController)
        module.presenter = presenter
        module.view = view

        return module
    }
}
