//  Created by илья on 03.08.23.

import Foundation
import Kingfisher
import UIKit

class TrendingCell: UICollectionViewCell {

    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let title: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trending news"
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        return label
    }()

    private var publishedTime: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.textColor = .systemBlue
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        layerSetup()
        setupLayout()
    }

    func setData(title: String, publishedTime: String, imageUrl: String) {
        self.title.text = title
        self.publishedTime.text = publishedTime
        self.imageView.kf.setImage(with: URL(string: imageUrl))
    }

    private func layerSetup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        layer.borderColor = UIColor.lightBlue.cgColor
    }

    private func setupLayout() {
        addSubview(imageView)
        addSubview(title)
        addSubview(label)
        addSubview(publishedTime)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 130),

            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            title.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            label.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            publishedTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            publishedTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}
