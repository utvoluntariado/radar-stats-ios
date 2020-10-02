//
//  ChartInfoView.swift
//  RadarSTATS
//
//  Original idea by Pedro José Pereira Vieito
//  Created by Jorge Juan Ramos Garnero on 27/09/2020.
//

import UIKit

protocol ChartInfoView: Noticeable {
    var presenter: ChartInfoPresenter! { get set }

    func update(title: String, description: String)
}

class ChartInfoViewController: UIViewController, ChartInfoView {
    var presenter: ChartInfoPresenter!

    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.gatherLocalization()
    }

    func update(title: String, description: String) {
        titleLabel.text = title
        descriptionTextView.text = description
    }

    @IBAction func didTapUnderstoodButton(_ sender: UIButton) {
        presenter.dismiss()
    }
}
