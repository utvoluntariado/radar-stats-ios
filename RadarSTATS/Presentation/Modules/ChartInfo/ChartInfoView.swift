//
//  ChartInfoView.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit

protocol ChartInfoView {
    var presenter: ChartInfoPresenter! { get set }
}

class ChartInfoViewController: UIViewController, ChartInfoView {
    var presenter: ChartInfoPresenter!

    @IBAction func didTapUnderstoodButton(_ sender: UIButton) {
        presenter.dismiss()
    }
}
