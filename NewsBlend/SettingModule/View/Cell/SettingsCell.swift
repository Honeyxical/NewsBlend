//  Created by илья on 08.08.23.

import Foundation
import UIKit

class SettingsCell: UITableViewCell {
    private let image: UIImageView = {
        let image = UIImageView()
        image.tintColor = .black
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let title: UILabel = {
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
        self.title.text = title
        setImage()
    }

    private func setImage() {
        switch title.text {
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
        addSubview(title)

        NSLayoutConstraint.activate([
            image.centerYAnchor.constraint(equalTo: centerYAnchor),
            image.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 50),
            image.heightAnchor.constraint(equalToConstant: 25),
            image.widthAnchor.constraint(equalToConstant: 25),

            title.leadingAnchor.constraint(equalTo: image.trailingAnchor, constant: 15),
            title.centerYAnchor.constraint(equalTo: centerYAnchor),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -25)
        ])
    }
}