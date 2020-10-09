//
//  WidgetExtension.swift
//  RadarSTATSWidgetExtension
//
//  Created by Pedro José Pereira Vieito on 4/10/20.
//

import Foundation
import SwiftUI
import WidgetKit

@main
struct WidgetExtension: WidgetBundle {
    var body: some Widget {
        MetricsSummaryWidget()
    }
}
