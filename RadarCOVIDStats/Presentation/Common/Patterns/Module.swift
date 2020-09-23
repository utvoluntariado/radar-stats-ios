//
//  Module.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge J. Ramos on 23/09/2020.
//

import UIKit

struct Module {
    var view: Any!
    var presenter: Any!
    var router: Any!

    var controller: UIViewController!

    init(controller: UIViewController) { self.controller = controller }
}

