//
//  ChartsPresenterTestable.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation
import XCTest

@testable import Radar_STATS

final class ChartsPresenterTestable: ChartsPresenterDefault {
    var expectation: XCTestExpectation?

    override func showCurrentData() {
        guard let expectation = expectation, expectation.description == ChartsExpectation.obtainStatsWhenGatherStatsSucceedButKeepAlreadyShownValues else { return }
        expectation.fulfill()
    }

    override func updateTable(using localization: Localization) {
        guard let expectation = expectation, expectation.description == ChartsExpectation.localizationIsPassedToViewWhenGatherLocalizationSucceed else { return }
        expectation.fulfill()
    }

    override func updateView(using stats: Stats) {
        guard let expectation = expectation, expectation.description == ChartsExpectation.statsArePassedToViewWhenGatherStatsSucceed else { return }
        expectation.fulfill()
    }

    override func alert(with error: Error) {
        guard let expectation = expectation else { return }
        if expectation.description == ChartsExpectation.anAlertIsShownWhenGatherStatsFails {
            expectation.fulfill()
        }
    }

    override func show(error: Error) {
        guard let expectation = expectation else { return }
        if expectation.description == ChartsExpectation.anErrorIsShownWhenGatherLocalizationFails {
            expectation.fulfill()
        }
    }
}
