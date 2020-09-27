//
//  InsettedImageButton.swift
//  RadarCOVIDStats
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit

@IBDesignable
final class InsettedSymbolButton: UIButton {
    private let inset: CGFloat = 12

    override func layoutSubviews() {
        super.layoutSubviews()
        contentEdgeInsets = UIEdgeInsets(top: inset, left: inset, bottom: inset, right: inset)
    }
}
