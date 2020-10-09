//
//  Alertable.swift
//  Radar STATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 08/10/2020.
//

import UIKit

protocol Alertable {

}

extension Alertable where Self: UIViewController {
    func alert(title: String?, message: String?, actions: [AlertAction]) {
        let alertViewController = UIAlertController(title: title, message: message, preferredStyle: .alert)
        for action in actions {
            let alertAction = UIAlertAction(title: action.title, style: cast(alertActionStyle: action.style)) { _ in action.action?() }
            alertViewController.addAction(alertAction)
        }
        self.present(alertViewController, animated: true, completion: nil)
    }

    private func cast(alertActionStyle: AlertActionStyle) -> UIAlertAction.Style {
        switch alertActionStyle {
        case .cancel: return .cancel
        case .destructive: return .destructive
        case .regular: return .default
        }
    }
}
