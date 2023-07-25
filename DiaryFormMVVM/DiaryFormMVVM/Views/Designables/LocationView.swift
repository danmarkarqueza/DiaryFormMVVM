//
//  LocationView.swift
//  DiaryFormMVVM
//
//  Created by Danmark Arqueza on 7/24/23.
//

import UIKit

class LocationView: UIView {

    private let iconImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.image = UIImage(named: "ic_location")
        imageView.tintColor = .gray
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()

    private let addressLabel: UILabel = {
        let label = UILabel()
        label.text = "20041075 | TAP-NS TAP-North Strathfield "
        label.textColor = .black 
        label.font = UIFont.systemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.numberOfLines = 2
        return label
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
        addSubview(iconImageView)
        addSubview(addressLabel)

        NSLayoutConstraint.activate([
            iconImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 20),
            iconImageView.centerYAnchor.constraint(equalTo: centerYAnchor),
            iconImageView.widthAnchor.constraint(equalToConstant: 24),
            iconImageView.heightAnchor.constraint(equalToConstant: 24),

            addressLabel.leadingAnchor.constraint(equalTo: iconImageView.trailingAnchor, constant: 8),
            addressLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            addressLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 20),
            addressLabel.heightAnchor.constraint(equalToConstant: 24)
        ])
    }
}
