//  Created by илья on 01.08.23.

import Foundation
import Kingfisher
import UIKit

final class ArticleFullCell: UICollectionViewCell {
    private let imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private let titleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont.systemFont(ofSize: 14)
        title.numberOfLines = 3
        return title
    }()

    private let authorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 11)
        label.textColor = .lightGray
        label.numberOfLines = 2
        return label
    }()

    private let publishedTimeLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        label.textColor = .systemBlue
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        imageView.image = nil
        titleLabel.text = nil
        authorLabel.text = nil
        publishedTimeLabel.text = nil
    }

    func setData(article: PresenterModel) {
        self.titleLabel.text = article.title
        self.authorLabel.text = article.author
        self.imageView.kf.setImage(with: URL(string: article.urlToImage))
        self.publishedTimeLabel.text = article.publishedAt
    }

    private func setupLayout() {
        addSubview(imageView)
        addSubview(titleLabel)
        addSubview(authorLabel)
        addSubview(publishedTimeLabel)

        let trailingOffset = 15.0
        let leadingOffset = 10.0
        let verticalOffset = 5.0

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: leadingOffset),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),

            titleLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: leadingOffset),
            titleLabel.topAnchor.constraint(equalTo: topAnchor, constant: verticalOffset),
            titleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailingOffset),

            authorLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: verticalOffset),
            authorLabel.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: leadingOffset),
            authorLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailingOffset),

            publishedTimeLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -trailingOffset),
            publishedTimeLabel.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -verticalOffset)
        ])
    }
}
