//  Created by илья on 08.08.23.

import Foundation
import UIKit

final class SettingsCell: UITableViewCell {
    private let image: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 16)
        return title
    }()

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setData(title: String){
        self.titleLabel.text = title
        setImage()
    }

    private func setImage() {
        switch titleLabel.text {
        case "Personal data":
            image.image = UIImage(systemName: "person")
        case "News sources":
            image.image = UIImage(systemName: "newspaper")
        case "Password":
            image.image = UIImage(systemName: "key.horizontal")
        case "Notification":
            image.image = UIImage(systemName: "bell")
        default:
            image.image = UIImage(systemName: "lasso")
        }
    }

    private func setupLayout() {
        addSubview(image)
        addSubview(titleLabel)

        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25),

            titleLabel.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            titleLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
}
