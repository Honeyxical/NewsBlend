//  Created by илья on 03.08.23.

import Foundation
import Kingfisher
import UIKit

final class TrendingCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let image = UIImageView()
        image.layer.cornerRadius = 10
        image.clipsToBounds = true
        image.contentMode = .scaleAspectFill
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.numberOfLines = 2
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    private let sectionTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Trending news"
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.numberOfLines = 1
        return label
    }()

    private var publishedTimeLabel: UILabel = {
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
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        publishedTimeLabel.text = nil
    }

    func setData(title: String?, timeSincePublication: String?, imageUrl: String) {
        titleLabel.text = title
        publishedTimeLabel.text = timeSincePublication
        imageView.kf.setImage(with: URL(string: imageUrl))
    }

    private func layerSetup() {
        layer.cornerRadius = 10
        layer.borderWidth = 1
        let lightBlue = UIColor(red: 230 / 255, green: 237 / 255, blue: 236 / 255, alpha: 1)
        layer.borderColor = lightBlue.cgColor
    }

    private func setupLayout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(sectionTitleLabel)
        addSubview(publishedTimeLabel)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor),
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.trailingAnchor.constraint(equalTo: trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 130),

            titleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            titleLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 15),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            sectionTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            sectionTitleLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15),

            publishedTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -20),
            publishedTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -15)
        ])
    }
}
