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
        let description = buildDescription(for: chartType, using: localization)
        view.update(title: chartTitle, description: description)
    }

    internal func buildDescription(for chartType: ChartType, using localization: Localization) -> NSAttributedString {
        let description = NSMutableAttributedString()

        let sectionTitleAttributes = [NSAttributedString.Key.font: view.descriptionSectionTitleFont, NSAttributedString.Key.foregroundColor: view.descriptionFontForegroundColor] as [NSAttributedString.Key : Any]
        let sectionBodyAttributes = [NSAttributedString.Key.font: view.descriptionSectionBodyFont, NSAttributedString.Key.foregroundColor: view.descriptionFontForegroundColor] as [NSAttributedString.Key : Any]

        let chartDescriptionTitle = NSAttributedString(string: "Descripción: \n", attributes: sectionTitleAttributes)
        let chartDescrition = NSAttributedString(string: "\(localization.charts[chartType.rawValue].content.description)\n\n\n", attributes: sectionBodyAttributes)
        description.append(chartDescriptionTitle)
        description.append(chartDescrition)

        switch chartType {
        case .generationDateSharedTEKs, .uploadDateSharedTEKs, .uploadedTEKsPerSharedDiagnosis:
            let basicDefinitionsTitle = NSAttributedString(string: "Glosario: \n", attributes: sectionTitleAttributes)
            let basicDefinitions = NSAttributedString(string: localization.definitions.tek.content.description, attributes: sectionBodyAttributes)

            description.append(basicDefinitionsTitle)
            description.append(basicDefinitions)
        default:
            break
        }

        return description
    }

    internal func show(error: Error) {
        view.show(error: error)
    }

    func dismiss() {
        router.navigate(to: .dismiss)
    }
}

