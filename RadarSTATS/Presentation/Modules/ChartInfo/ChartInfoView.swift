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
    var descriptionSectionHeaderFont: UIFont { get }
    var descriptionSectionBodyTitleFont: UIFont { get }
    var descriptionSectionBodyTitleUnderlineStyle: Int { get }
    var descriptionSectionBodyFont: UIFont { get }
    var descriptionFontForegroundColor: UIColor { get }

    func update(title: String, description: NSAttributedString)
}

class ChartInfoViewController: UIViewController, ChartInfoView {
    var presenter: ChartInfoPresenter!

    var descriptionSectionHeaderFont: UIFont { UIFont.systemFont(ofSize: 25, weight: .semibold) }
    var descriptionSectionBodyTitleFont: UIFont { UIFont.systemFont(ofSize: 20, weight: .medium) }
    var descriptionSectionBodyTitleUnderlineStyle: Int { return NSUnderlineStyle.single.rawValue }
    var descriptionSectionBodyFont: UIFont { UIFont.systemFont(ofSize: 20, weight: .regular) }
    var descriptionFontForegroundColor: UIColor { UIColor(named: "fontForeground")! }

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
