//
//  ChartsTests.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import XCTest

@testable import Radar_STATS

class ChartsTests: XCTestCase {
    var presenter: ChartsPresenterTestable!

    override func setUpWithError() throws {
        TestingInjector.prepareMockInjections()
        presenter = (ChartsBuilder.build.presenter as! ChartsPresenterTestable)
    }

    override func tearDownWithError() throws {
        TestingInjector.resetInjections()
    }

    func test_anAlertIsShownWhenGatherStatsFails() throws {
        measure {
            presenter.expectation = expectation(description: ChartsExpectation.anAlertIsShownWhenGatherStatsFails)
            (presenter.statsInteractor.repository as! StatsRepositoryMock).shouldFail = true
            presenter.gatherStats(viewIsAlreadyShowingValues: true)

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }

    func test_statsArePassedToViewWhenGatherStatsSucceed() throws {
        measure {
            presenter.expectation = expectation(description: ChartsExpectation.statsArePassedToViewWhenGatherStatsSucceed)
            (presenter.statsInteractor.repository as! StatsRepositoryMock).shouldFail = false
            presenter.gatherStats(viewIsAlreadyShowingValues: false)

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }

    func test_obtainStatsWhenGatherStatsSucceedButKeepAlreadyShownValues() throws {
        measure {
            presenter.expectation = expectation(description: ChartsExpectation.obtainStatsWhenGatherStatsSucceedButKeepAlreadyShownValues)
            (presenter.statsInteractor.repository as! StatsRepositoryMock).shouldFail = false
            presenter.gatherStats(viewIsAlreadyShowingValues: true)

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }

    func test_anErrorIsShownWhenGatherLocalizationFails() throws {
        measure {
            presenter.expectation = expectation(description: ChartsExpectation.anErrorIsShownWhenGatherLocalizationFails)
            (presenter.localizationInteractor.repository as! LocalizationRepositoryMock).shouldFail = true
            presenter.gatherLocalization()

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }

    func test_localizationIsPassedToViewWhenGatherLocalizationSucceed() throws {
        measure {
            presenter.expectation = expectation(description: ChartsExpectation.localizationIsPassedToViewWhenGatherLocalizationSucceed)
            (presenter.localizationInteractor.repository as! LocalizationRepositoryMock).shouldFail = false
            presenter.gatherLocalization()

            waitForExpectations(timeout: 3) { (error) in
                XCTAssertNil(error, error!.localizedDescription)
            }
        }
    }
}
