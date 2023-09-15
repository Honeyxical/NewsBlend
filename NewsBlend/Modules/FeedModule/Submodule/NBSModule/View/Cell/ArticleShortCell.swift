//  Created by илья on 17.08.23.

import UIKit

final class ArticleShortCell: UICollectionViewCell {
    private let articleTitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private let articleAuthorLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()

    private let publishedAtLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.textColor = .systemBlue
        label.numberOfLines = 1
        return label
    }()

    override func prepareForReuse() {
        super.prepareForReuse()
        articleTitleLabel.text = nil
        articleAuthorLabel.text = nil
        publishedAtLabel.text = nil
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension ArticleShortCell {
    func setData(article: ArticleModel) {
        self.articleTitleLabel.text = article.title
        self.articleAuthorLabel.text = "By " + (article.author ?? "unknown author")
        self.publishedAtLabel.text = article.timeSincePublication
    }

    private func setupLayout() {
        addSubview(articleTitleLabel)
        addSubview(articleAuthorLabel)
        addSubview(publishedAtLabel)

        let horizontalOffset = 15.0
        let verticalOffset = 10.0

        NSLayoutConstraint.activate([
            articleTitleLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalOffset),
            articleTitleLabel.topAnchor.constraint(equalTo: topAnchor),
            articleTitleLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalOffset),

            articleAuthorLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: horizontalOffset),
            articleAuthorLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: verticalOffset),
            articleAuthorLabel.widthAnchor.constraint(equalToConstant: frame.width / 1.50),

            publishedAtLabel.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: verticalOffset),
            publishedAtLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -horizontalOffset)
        ])
    }
}
