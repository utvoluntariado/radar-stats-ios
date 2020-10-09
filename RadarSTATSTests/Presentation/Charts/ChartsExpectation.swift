//
//  ChartsExpectation.swift
//  RadarSTATSTests
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 30/09/2020.
//

import Foundation

struct ChartsExpectation {
    static let anAlertIsShownWhenGatherStatsFails = "An alert is shown when GatherStats fails for any reason"
    static let statsArePassedToViewWhenGatherStatsSucceed = "Stats are passed to view when GatherStats succeed"
    static let obtainStatsWhenGatherStatsSucceedButKeepAlreadyShownValues = "Did obtain stats when GatherStats succeed, but it's the same info currently in view"

    static let anErrorIsShownWhenGatherLocalizationFails = "An error is shown when GatherLocalization fails for any reason"
    static let localizationIsPassedToViewWhenGatherLocalizationSucceed = "Localization is passed to view when GatherLocalization succeed"
}
