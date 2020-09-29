//
//  StatsInteractor.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 24/09/2020.
//

import Foundation
import PromiseKit

protocol StatsInteractor {
    var repository: StatsRepository! { get set }

    func run() -> Promise<Stats>
}

final class StatsInteractorDefault: StatsInteractor {
    var repository: StatsRepository!

    func run() -> Promise<Stats> {
        return repository.stats()
    }
}
