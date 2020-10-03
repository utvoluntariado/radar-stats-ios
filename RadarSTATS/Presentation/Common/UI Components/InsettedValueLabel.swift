//
//  InsettedValueLabel.swift
//  Radar STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 03/10/2020.
//

import UIKit

@IBDesignable
final class InsettedValueLabel: UILabel {
    @IBInspectable var topInset: CGFloat = 4.0
    @IBInspectable var bottomInset: CGFloat = 4.0
    @IBInspectable var leftInset: CGFloat = 4.0
    @IBInspectable var rightInset: CGFloat = 4.0

    override var intrinsicContentSize: CGSize {
        let size = super.intrinsicContentSize
        let width = size.width < 75 ? 75 : size.width
        return CGSize(width: width + leftInset + rightInset, height: size.height + topInset + bottomInset)
    }

    override var bounds: CGRect {
        didSet {
            preferredMaxLayoutWidth = bounds.width - (leftInset + rightInset)
        }
    }

    override func drawText(in rect: CGRect) {
        let insets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawText(in: rect.inset(by: insets))
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        clipsToBounds = true
        layer.cornerRadius = layer.bounds.height * 0.5
    }

    override func prepareForInterfaceBuilder() {
        layoutIfNeeded()
    }
}
