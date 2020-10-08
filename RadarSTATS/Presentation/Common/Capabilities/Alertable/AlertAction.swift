//
//  AlertAction.swift
//  Radar STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 08/10/2020.
//

import Foundation

enum AlertActionStyle {
    case regular
    case destructive
    case cancel
}

struct AlertAction {
    var title: String
    var action: (() -> Void)?
    var style: AlertActionStyle
}
