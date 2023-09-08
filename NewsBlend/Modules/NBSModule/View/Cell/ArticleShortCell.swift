//  Created by илья on 17.08.23.

import UIKit

class ArticleShortCell: UICollectionViewCell {
    private let articleTitle: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()

    private let articleAuthor: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12)
        label.textColor = .lightGray
        label.numberOfLines = 1
        return label
    }()

    private let publishedAt: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = .systemFont(ofSize: 12, weight: .thin)
        label.textColor = .systemBlue
        label.numberOfLines = 1
        return label
    }()
}

extension ArticleShortCell {
    func setData(articleTitle: String, articleAuthor: String, publishedAt: String) {
        self.articleTitle.text = articleTitle
        self.articleAuthor.text = "By " + articleAuthor
        self.publishedAt.text = publishedAt
        setupLayout()
    }

    private func setupLayout() {
        addSubview(articleTitle)
        addSubview(articleAuthor)
        addSubview(publishedAt)

        NSLayoutConstraint.activate([
            articleTitle.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 15),
            articleTitle.topAnchor.constraint(equalTo: topAnchor),
            articleTitle.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            articleAuthor.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 25),
            articleAuthor.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10),
            articleAuthor.widthAnchor.constraint(equalToConstant: frame.width / 1.50),

            publishedAt.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 10),
            publishedAt.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15)
        ])
    }
}
