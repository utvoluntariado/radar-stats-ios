//
//  ChartInfoTests.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 02/10/2020.
//

import XCTest

@testable import Radar_STATS

class ChartInfoTests: XCTestCase {
    var presenter: ChartInfoPresenterTestable!

    override func setUpWithError() throws {
        TestingInjector.prepareMockInjections()
    }

    override func tearDownWithError() throws {
        TestingInjector.resetInjections()
    }

    func test_anErrorIsShownWhenGatherLocalizationFails() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .covidCases).presenter as! ChartInfoPresenterTestable)
            presenter.expectation = expectation(description: ChartInfoExpectation.anErrorIsShownWhenGatherLocalizationFails)
            (presenter.localizationInteractor.repository as! LocalizationRepositoryMock).shouldFail = true
            presenter.gatherLocalization()

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }

    func test_localizationIsPassedToViewWhenGatherLocalizationSucceed() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .covidCases).presenter as! ChartInfoPresenterTestable)
            presenter.expectation = expectation(description: ChartInfoExpectation.localizationIsPassedToViewWhenGatherLocalizationSucceed)
            (presenter.localizationInteractor.repository as! LocalizationRepositoryMock).shouldFail = false
            presenter.gatherLocalization()

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }
}

