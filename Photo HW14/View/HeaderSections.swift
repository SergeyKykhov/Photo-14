//
//  HeaderSections.swift
//  Photo HW14
//
//  Created by Sergey Kykhov on 27.06.2022.
//

import UIKit
class HeaderSections: UICollectionReusableView {

    static let identifier = "HeaderSections"
    let lineGray = UIView()
    let leftHeader = UILabel()
    let rightButton: UIButton = {
        let rightButton = UIButton(type: .system)
        rightButton.setTitle("Всe", for: .normal)
        rightButton.setTitleColor(UIColor.systemBlue, for: .normal)
        rightButton.titleLabel?.font = .systemFont(ofSize: 18, weight: .regular)
        return rightButton
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
leftHeader.translatesAutoresizingMaskIntoConstraints = false

        lineGray.translatesAutoresizingMaskIntoConstraints = false
        lineGray.backgroundColor = .lightGray

        rightButton.translatesAutoresizingMaskIntoConstraints = false
        rightButton.addTarget(self, action: #selector(presseRightButton), for: .touchUpInside)

        addSubview(leftHeader)
        addSubview(lineGray)
        addSubview(rightButton)

        NSLayoutConstraint.activate([
            leftHeader.topAnchor.constraint(equalTo: self.topAnchor),
            leftHeader.leadingAnchor.constraint(equalTo: self.leadingAnchor),
            leftHeader.trailingAnchor.constraint(equalTo: self.trailingAnchor),
            leftHeader.bottomAnchor.constraint(equalTo: self.bottomAnchor),

            lineGray.topAnchor.constraint(equalTo: self.topAnchor, constant: -5),
            lineGray.leadingAnchor.constraint(equalTo: self.leadingAnchor, constant: 0),
            lineGray.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: 0),
            lineGray.heightAnchor.constraint(equalToConstant: 0.5),

            rightButton.topAnchor.constraint(equalTo: leftHeader.topAnchor),
            rightButton.trailingAnchor.constraint(equalTo: self.trailingAnchor, constant: -15)
        ])
    }

    func containerViewSettings(text: String, textColor: UIColor, font: UIFont?) {
        leftHeader.textColor = textColor
        leftHeader.font = font
        leftHeader.text = text
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    @objc private func presseRightButton() {
        print(leftHeader.text!)
    }
}

