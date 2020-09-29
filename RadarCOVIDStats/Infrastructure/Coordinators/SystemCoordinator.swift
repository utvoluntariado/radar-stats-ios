//
//  SystemCoordinator.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import Foundation

protocol SystemCoordinator {
    var isAnyModuleLoading: Bool { get set }
}

class SystemCoordinatorDefault: SystemCoordinator {
    var isAnyModuleLoading: Bool = false
}
