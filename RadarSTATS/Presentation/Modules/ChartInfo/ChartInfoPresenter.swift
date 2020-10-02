//
//  ChartInfoPresenter.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import Foundation

protocol ChartInfoPresenter {
    var router: ChartInfoRouter! { get set }
    var view: ChartInfoView! { get set }

    var localizationInteractor: LocalizationInteractor! { get set }
    var chartType: ChartType! { get set }

    func gatherLocalization()
    func dismiss()
}

class ChartInfoPresenterDefault: ChartInfoPresenter {
    var router: ChartInfoRouter!
    var view: ChartInfoView!

    var localizationInteractor: LocalizationInteractor!
    var chartType: ChartType!

    func gatherLocalization() {
        localizationInteractor.run().done { localization in
            self.updateView(using: localization)
        }.catch { error in
            self.show(error: error)
        }
    }

    internal func updateView(using localization: Localization) {
        let chartTitle = localization.charts[chartType.rawValue].content.title ?? ""

        var description: String
        switch chartType {
        case .generationDateSharedTEKs, .uploadDateSharedTEKs, .uploadedTEKsPerSharedDiagnosis:
            description = "\(localization.charts[chartType.rawValue].content.description) \n\n *Definiciones: \n\(localization.definitions.tek.content.description)"
        default:
            description = localization.charts[chartType.rawValue].content.description
        }

        view.update(title: chartTitle, description: description)
    }

    internal func show(error: Error) {
        view.show(error: error)
    }

    func dismiss() {
        router.navigate(to: .dismiss)
    }
}

