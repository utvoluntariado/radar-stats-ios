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

    override func updateView(using localization: Localization) {
        guard let expectation = expectation, expectation.description == ChartInfoExpectation.localizationIsPassedToViewWhenGatherLocalizationSucceed else { return }
        expectation.fulfill()
    }

    override func show(error: Error) {
        guard let expectation = expectation, expectation.description == ChartInfoExpectation.anErrorIsShownWhenGatherLocalizationFails else { return }
        expectation.fulfill()
    }
}

