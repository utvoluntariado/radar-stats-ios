//
//  LocalizationInteractor.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 01/10/2020.
//

import Foundation
import PromiseKit

protocol LocalizationInteractor {
    var repository: LocalizationRepository! { get set }

    func run() -> Promise<Localization>
}

final class LocalizationInteractorDefault: LocalizationInteractor {
    var repository: LocalizationRepository!

    func run() -> Promise<Localization> {
        return repository.localizations()
    }
}
