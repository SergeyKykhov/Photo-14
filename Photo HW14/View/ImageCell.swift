//
//  ImageCell.swift
//  Photo HW14
//
//  Created by Sergey Kykhov on 27.06.2022.
//

import UIKit

class ImageCell: UICollectionViewCell {
    static let identifier = "ImageCell"
    let containerView = UIView()
    let image = UIImageView()
    let nameFooter = UILabel()
    let imageCount: UILabel = {
        let lable = UILabel()
        lable.textColor = .systemGray
        return lable
    }()
    override func prepareForReuse() {
        super.prepareForReuse()
        image.image = nil
        nameFooter.text = nil
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        let cornerRadius = CGFloat(5)
        self.containerView.layer.cornerRadius = cornerRadius
        self.layer.cornerRadius = cornerRadius
        self.containerView.clipsToBounds = true
        self.image.layer.cornerRadius = cornerRadius
        self.image.clipsToBounds = true
        self.image.contentMode = .scaleAspectFill
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .white
        allConstraints()
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    func containerViewSettings(image: String, nameFooter: String, imageCount: Int) {
        self.image.image = UIImage(named: image)
        self.nameFooter.text = nameFooter
        self.imageCount.text = "\(imageCount)"
    }
    func allConstraints() {
        containerView.translatesAutoresizingMaskIntoConstraints = false
        image.translatesAutoresizingMaskIntoConstraints = false
        nameFooter.translatesAutoresizingMaskIntoConstraints = false
        imageCount.translatesAutoresizingMaskIntoConstraints = false

        addSubview(containerView)
        containerView.addSubview(image)
        containerView.addSubview(nameFooter)
        containerView.addSubview(imageCount)

        NSLayoutConstraint.activate([
            containerView.topAnchor.constraint(equalTo: self.topAnchor),
            containerView.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            containerView.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            containerView.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            image.topAnchor.constraint(equalTo: containerView.topAnchor),
            image.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),
            image.trailingAnchor.constraint(equalTo: containerView.trailingAnchor),
            image.heightAnchor.constraint(equalToConstant: 190),

            nameFooter.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 5),
            nameFooter.leadingAnchor.constraint(equalTo: containerView.leadingAnchor),

            imageCount.topAnchor.constraint(equalTo: image.bottomAnchor, constant: 25),
            imageCount.leadingAnchor.constraint(equalTo: containerView.leadingAnchor)
        ])

    }
}

