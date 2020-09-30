//
//  ChartsPresenterTestable.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation
import XCTest

@testable import RadarCOVID_STATS

final class ChartsPresenterTestable: ChartsPresenterDefault {
    var expectation: XCTestExpectation?

    override func show(error: Error) {
        guard let expectation = expectation, expectation.description == ChartsExpectation.anErrorIsShownWhenGatherStatsFails else { return }
        expectation.fulfill()
    }
}
