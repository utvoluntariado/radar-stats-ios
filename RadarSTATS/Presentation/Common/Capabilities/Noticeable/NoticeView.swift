//
//  NoticeLayerView.swift
//  RadarSTATS
//
//  Created by Jorge Juan Ramos Garnero on 29/09/2020.
//

import UIKit

enum NoticeMode {
    case info
    case warning
    case error
}

struct Notice {
    private(set) var mood: String
    var text: String
    var mode: NoticeMode

    init(text: String, mode: NoticeMode) {
        switch mode {
        case .error: self.mood = "🤯"
        case .info: self.mood = "🤓"
        case .warning: self.mood = "🙄"
        }

        self.text = text
        self.mode = mode
    }

    init(error: Error) {
        self.mood = "🤯"
        self.text = error.localizedDescription
        self.mode = .error
    }

    init(error: LocalizedError) {
        self.mood = "🤯"
        self.text = error.errorDescription ?? error.localizedDescription
        self.mode = .error
    }
}

final class NoticeView: UIView {
    private var notice: Notice!

    private let contentView = UIView()
    private let textStack = UIStackView()
    private let moodLabel = UILabel()
    private let textLabel = UILabel()

    convenience init(notice: Notice, window: UIWindow) {
        self.init(frame: CGRect.zero)
        prepareInterface(notice: notice)
        formatInterface(notice: notice)
        layoutIfNeeded()
        drawShadow()
    }

    private func prepareInterface(notice: Notice) {
        autoresizingMask = [.flexibleHeight]
        translatesAutoresizingMaskIntoConstraints = false

        contentView.translatesAutoresizingMaskIntoConstraints = false
        addSubview(contentView)
        contentView.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: topAnchor).isActive = true
        contentView.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: bottomAnchor).isActive = true

        textStack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(textStack)
        textStack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        textStack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        textStack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        textStack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        moodLabel.translatesAutoresizingMaskIntoConstraints = false
        moodLabel.widthAnchor.constraint(equalToConstant: 64).isActive = true
        textStack.addArrangedSubview(moodLabel)

        textLabel.translatesAutoresizingMaskIntoConstraints = false
        textStack.addArrangedSubview(textLabel)
    }

    private func formatInterface(notice: Notice) {
        backgroundColor = .clear

        contentView.clipsToBounds = true
        contentView.layer.cornerRadius = 8

        textStack.alignment = .fill
        textStack.axis = .horizontal
        textStack.distribution = .fill
        textStack.spacing = 0

        moodLabel.text = notice.mood
        moodLabel.font = UIFont.boldSystemFont(ofSize: 40)
        moodLabel.numberOfLines = 1
        moodLabel.textAlignment = .center
        moodLabel.lineBreakMode = .byWordWrapping

        textLabel.text = notice.text
        textLabel.font = UIFont.systemFont(ofSize: 14, weight: .medium)
        textLabel.numberOfLines = 0
        textLabel.lineBreakMode = .byWordWrapping

        switch notice.mode {
        case .info:
            contentView.backgroundColor = #colorLiteral(red: 0.2039215686, green: 0.5960784314, blue: 0.8588235294, alpha: 1)
            textLabel.textColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        case .warning:
            contentView.backgroundColor = #colorLiteral(red: 0.9450980392, green: 0.768627451, blue: 0.05882352941, alpha: 1)
            textLabel.textColor = #colorLiteral(red: 0.1764705882, green: 0.1764705882, blue: 0.1764705882, alpha: 1)
        case .error:
            contentView.backgroundColor = #colorLiteral(red: 0.9058823529, green: 0.2980392157, blue: 0.2352941176, alpha: 1)
            textLabel.textColor = #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1)
        }
    }

    private func drawShadow() {
        layer.shadowOffset = CGSize(width: 0, height: 1)
        layer.shadowColor = UIColor.black.cgColor
        layer.shadowOpacity = 0.6
        layer.shadowRadius = 3.0
    }
}

