//
//  TextCell.swift
//  Photo HW14
//
//  Created by Sergey Kykhov on 27.06.2022.
//

import UIKit

class TextCell: UICollectionViewCell {
    static let identifier = "TextCell"

    let image = UIImageView()

    let leftLabel: UILabel = {
        let leftlabel = UILabel()
        leftlabel.textColor = .systemBlue
        leftlabel.font = .systemFont(ofSize: 20, weight: .regular)
        return leftlabel
    }()

    let countImage: UILabel = {
        let label = UILabel()
        label.textColor = .systemGray
        return label
    }()

    let accessory = UIImageView()
    let lineGray = UIView()


    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        leftLabel.text = nil
        accessory.image = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)

        allConstraints()
    }

    func containerViewSettings(image: String, leftLabel: String, imageCount: Int) {
        self.leftLabel.text = leftLabel
        self.image.image = UIImage(systemName: image)
        self.countImage.text = "\(imageCount)"

        let rightToLeft = effectiveUserInterfaceLayoutDirection == .rightToLeft
        let chevronImageName = rightToLeft ? "chevron.left" : "chevron.right"
        let chevronImage = UIImage(systemName: chevronImageName)
        accessory.image = chevronImage
        accessory.tintColor = UIColor.lightGray.withAlphaComponent(0.7)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func allConstraints() {
        image.translatesAutoresizingMaskIntoConstraints = false
        leftLabel.translatesAutoresizingMaskIntoConstraints = false
        countImage.translatesAutoresizingMaskIntoConstraints = false
        accessory.translatesAutoresizingMaskIntoConstraints = false
        lineGray.translatesAutoresizingMaskIntoConstraints = false

        addSubview(image)
        addSubview(leftLabel)
        addSubview(countImage)
        addSubview(accessory)
        addSubview(lineGray)

        image.contentMode = .center
        lineGray.backgroundColor = .lightGray

        selectedBackgroundView = UIView()
        selectedBackgroundView?.backgroundColor = UIColor.lightGray.withAlphaComponent(0.3)

        NSLayoutConstraint.activate([
            image.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            image.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            image.heightAnchor.constraint(equalTo: heightAnchor, constant: -15),
            image.widthAnchor.constraint(equalTo: heightAnchor, constant: -15),

            leftLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            leftLabel.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 0),
            leftLabel.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 0),
            leftLabel.trailingAnchor.constraint(equalTo: accessory.leadingAnchor, constant: 0),

            countImage.trailingAnchor.constraint(equalTo: accessory.leadingAnchor, constant: -5),
            countImage.centerYAnchor.constraint(equalTo: self.centerYAnchor),

            accessory.centerYAnchor.constraint(equalTo: contentView.centerYAnchor),
            accessory.widthAnchor.constraint(equalToConstant: 13),
            accessory.heightAnchor.constraint(equalToConstant: 20),
            accessory.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant:  -10),

            lineGray.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 10),
            lineGray.bottomAnchor.constraint(equalTo: self.bottomAnchor),
            lineGray.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            lineGray.heightAnchor.constraint(equalToConstant: 0.5)
        ])
    }

}

