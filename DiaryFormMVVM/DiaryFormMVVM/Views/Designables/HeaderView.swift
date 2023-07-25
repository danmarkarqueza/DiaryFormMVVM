//
//  HeaderView.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class HeaderView: UIView {

    private let titleLabel: UILabel = {
        let label = UILabel()
        label.text = "Add to site diary"
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.textColor = .black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let helpButton: UIButton = {
        let button = UIButton(type: .system)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 16)
        button.tintColor = .blue
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setImage(UIImage(systemName: "questionmark.circle.fill"), for: .normal)
        button.tintColor = UIColor.gray
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupViews()
    }

    private func setupViews() {
        addSubview(titleLabel)
        addSubview(helpButton)
        backgroundColor = UIColor.colorWithRGBHex(0xFFF2F5F7)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: topAnchor),
            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: helpButton.leadingAnchor, constant: -8),

            helpButton.topAnchor.constraint(equalTo: topAnchor),
            helpButton.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            helpButton.widthAnchor.constraint(equalToConstant: 48),
            helpButton.heightAnchor.constraint(equalToConstant: 48),
            helpButton.bottomAnchor.constraint(equalTo: titleLabel.bottomAnchor) 
        ])
    }
}
