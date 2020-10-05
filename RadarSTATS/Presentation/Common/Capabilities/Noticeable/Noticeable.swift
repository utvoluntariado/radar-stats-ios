//
//  Noticeable.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

protocol Noticeable {

}

extension Noticeable {
    var isAlreadyShowingANotice: Bool {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), keyWindow.subviews.filter({$0 is NoticeView}).count == 0 {
            return false
        } else {
            return true
        }
    }

    func show(error: Error, disappearing: Bool = true) {
        let notice = Notice(error: error)
        show(notice: notice, disappearing: disappearing)
    }

    func show(notice: Notice, disappearing: Bool = true) {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            let noticeView = NoticeView(notice: notice, window: keyWindow)
            arrangeNotice(view: noticeView, disappearing: disappearing)
        }
    }

    private func arrangeNotice(view: NoticeView, disappearing: Bool) {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }), keyWindow.subviews.filter({$0 is NoticeView}).count == 0 {
            keyWindow.addSubview(view)

            let topConstraintInitialValue = -(view.bounds.height + keyWindow.safeAreaInsets.top)

            view.translatesAutoresizingMaskIntoConstraints = false
            view.centerXAnchor.constraint(equalTo: keyWindow.centerXAnchor).isActive = true
            view.widthAnchor.constraint(equalToConstant: UIDevice.current.userInterfaceIdiom == .phone ? (keyWindow.bounds.width - 32) : (keyWindow.bounds.width / 2)).isActive = true
            keyWindow.layoutIfNeeded()

            let topConstraint = view.topAnchor.constraint(equalTo: keyWindow.safeAreaLayoutGuide.topAnchor, constant: topConstraintInitialValue)
            topConstraint.isActive = true

            animateEntry(view: view, disappearing: disappearing, topConstraint: topConstraint)
        }
    }

    private func animateEntry(view: NoticeView, disappearing: Bool, topConstraint: NSLayoutConstraint) {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            topConstraint.constant = 16
            UIView.animate(withDuration: 0.7, delay: 0.0, usingSpringWithDamping: 0.5, initialSpringVelocity: 0.5, options: .curveEaseInOut, animations: {
                keyWindow.layoutIfNeeded()
            }, completion: { completed in
                if completed && disappearing {
                    self.animateExit(view: view, topConstraint: topConstraint)
                }
            })
        }
    }

    private func animateExit(view: NoticeView, topConstraint: NSLayoutConstraint) {
        if let keyWindow = UIApplication.shared.windows.first(where: { $0.isKeyWindow }) {
            Timer.scheduledTimer(withTimeInterval: 4, repeats: false, block: { timer in
                topConstraint.constant = 24
                UIView.animate(withDuration: 0.4, delay: 0.0, options: .curveEaseInOut, animations: {
                    keyWindow.layoutIfNeeded()
                }, completion: { completed in
                    if completed {
                        let topConstraintInitialValue = -(view.bounds.height + keyWindow.safeAreaInsets.top)
                        topConstraint.constant = topConstraintInitialValue
                        UIView.animate(withDuration: 0.3, delay: 0.0, options: .curveEaseInOut, animations: {
                            keyWindow.layoutIfNeeded()
                        }, completion: { completed in
                            if completed {
                                view.removeFromSuperview()
                                timer.invalidate()
                            }
                        })
                    }
                })
            })
        }
    }
}
