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

    func test_glossaryIsPresentOnSharedTEKsByGenerationDateChartDescription() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .generationDateSharedTEKs).presenter as! ChartInfoPresenterTestable)
            let description = presenter.descriptionGenerator()

            XCTAssert(description.contains("Glosario"), "Glossary not found on .generationDateSharedTEKs chart description")
        }
    }

    func test_glossaryIsPresentOnSharedTEKsByUploadDateChartDescription() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .uploadDateSharedTEKs).presenter as! ChartInfoPresenterTestable)
            let description = presenter.descriptionGenerator()

            XCTAssert(description.contains("Glosario"), "Glossary not found on .uploadDateSharedTEKs chart description")
        }
    }

    func test_glossaryIsPresentOnUploadedTEKsBySharedDiagnosisChartDescription() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .uploadedTEKsPerSharedDiagnosis).presenter as! ChartInfoPresenterTestable)
            let description = presenter.descriptionGenerator()

            XCTAssert(description.contains("Glosario"), "Glossary not found on .uploadedTEKsPerSharedDiagnosis chart description")
        }
    }

    func test_glossaryIsNotPresentOnCovidCasesChartDescription() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .covidCases).presenter as! ChartInfoPresenterTestable)
            let description = presenter.descriptionGenerator()

            XCTAssert(!description.contains("Glosario"), "Glossary found on .covidCases chart description")
        }
    }

    func test_glossaryIsNotPresentOnCovidUsageRatioDescription() throws {
        measure {
            presenter = (ChartInfoBuilder.build(chartType: .usageRatio).presenter as! ChartInfoPresenterTestable)
            let description = presenter.descriptionGenerator()

            XCTAssert(!description.contains("Glosario"), "Glossary found on .usageRatio chart description")
        }
    }
}
