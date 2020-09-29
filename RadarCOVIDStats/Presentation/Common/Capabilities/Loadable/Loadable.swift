//
//  Loadable.swift
//  RadarCOVID STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

protocol Loadable {

}

extension Loadable {
    mutating func showLoading() {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }

        var systemCoordinator = <~SystemCoordinator.self
        if !systemCoordinator.isAnyModuleLoading {
            systemCoordinator.isAnyModuleLoading.toggle()

            let loadingView = LoadingLayerView(frame: keyWindow.frame)
            loadingView.backgroundColor = .black
            loadingView.alpha = 0.0
            keyWindow.insertSubview(loadingView, at: keyWindow.subviews.count)

            UIView.animate(withDuration: 0.38) { loadingView.alpha = 1.0 }
        }
    }

    mutating func hideLoading(_ completion: (() -> Void)?) {
        guard let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) else { return }
        guard let loadingView = keyWindow.subviews.filter({ $0 is LoadingLayerView }).first else { return }

        var systemCoordinator = <~SystemCoordinator.self
        if systemCoordinator.isAnyModuleLoading {
            UIView.animate(withDuration: 0.38) {
                loadingView.alpha = 0.0
            } completion: { (completed) in
                if completed {
                    loadingView.removeFromSuperview()
                    systemCoordinator.isAnyModuleLoading.toggle()
                    completion?()
                }
            }
        }
    }
}
