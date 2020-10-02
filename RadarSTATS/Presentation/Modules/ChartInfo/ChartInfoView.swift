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
    var descriptionSectionTitleFont: UIFont { get }
    var descriptionSectionBodyFont: UIFont { get }
    var descriptionFontForegroundColor: UIColor { get }

    func update(title: String, description: NSAttributedString)
}

class ChartInfoViewController: UIViewController, ChartInfoView {
    var presenter: ChartInfoPresenter!

    var descriptionSectionTitleFont: UIFont { UIFont.systemFont(ofSize: 25, weight: .semibold) }
    var descriptionSectionBodyFont: UIFont { UIFont.systemFont(ofSize: 20, weight: .medium) }
    var descriptionFontForegroundColor: UIColor { #colorLiteral(red: 0.9330000281, green: 0.9330000281, blue: 0.9330000281, alpha: 1) }

    @IBOutlet private weak var descriptionTextView: UITextView!
    @IBOutlet private weak var titleLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.gatherLocalization()
    }

    func update(title: String, description: NSAttributedString) {
        titleLabel.text = title
        descriptionTextView.attributedText = description
    }

    @IBAction func didTapUnderstoodButton(_ sender: UIButton) {
        presenter.dismiss()
    }
}
