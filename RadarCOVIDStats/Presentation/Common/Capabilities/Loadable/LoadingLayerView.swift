//
//  LoadingLayerView.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

final class LoadingLayerView: UIView {
    private var indicatorView = UIActivityIndicatorView(style: .large)

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
        commonInit()
    }

    private func commonInit() {
        isOpaque = false

        indicatorView.startAnimating()
        addSubview(indicatorView)
        indicatorView.translatesAutoresizingMaskIntoConstraints = false
        indicatorView.centerYAnchor.constraint(equalTo: centerYAnchor).isActive = true
        indicatorView.centerXAnchor.constraint(equalTo: centerXAnchor).isActive = true
    }

    override func layoutSubviews() {
        super.layoutSubviews()
        backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    }
}
