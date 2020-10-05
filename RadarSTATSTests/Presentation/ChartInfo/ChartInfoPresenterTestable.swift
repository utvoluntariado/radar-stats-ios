//
//  ChartInfoPresenterTestable.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 02/10/2020.
//

import Foundation
import XCTest

@testable import Radar_STATS

final class ChartInfoPresenterTestable: ChartInfoPresenterDefault {
    var expectation: XCTestExpectation?

    private var localization: Localization!

    func descriptionGenerator() -> String {
        do {
            let jsonPath = Bundle.main.path(forResource: "localization", ofType: "json")
            let jsonData = try String(contentsOfFile: jsonPath!).data(using: .utf8)!
            localization = try JSONDecoder().decode(Localization.self, from: jsonData)
            let description = buildDescription(for: chartType, using: localization)
            return description.string
        } catch {
            return ""
        }
    }
    
    override func updateView(using localization: Localization) {
        self.localization = localization
        guard let expectation = expectation, expectation.description == ChartInfoExpectation.localizationIsPassedToViewWhenGatherLocalizationSucceed else { return }
        expectation.fulfill()
    }

    override func show(error: Error) {
        guard let expectation = expectation, expectation.description == ChartInfoExpectation.anErrorIsShownWhenGatherLocalizationFails else { return }
        expectation.fulfill()
    }
}

