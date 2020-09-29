//
//  MainBuilder.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 23/09/2020.
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

        var module = Module(controller: viewController)
        module.view = view

        return module
    }
}

