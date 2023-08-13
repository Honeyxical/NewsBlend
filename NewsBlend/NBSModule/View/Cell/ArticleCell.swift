//  Created by илья on 01.08.23.

import Foundation
import Kingfisher
import UIKit

class ArticleCell: UICollectionViewCell {
    private var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.layer.cornerRadius = 20
        imageView.clipsToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()

    private var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.numberOfLines = 3
        return title
    }()

    private var author: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = .lightGray
        label.numberOfLines = 2
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
        setupLayout()
    }

    func setData(title: String, author: String, imageUrl: String, publishedTime: String) {
        self.title.text = title
        self.author.text = "By " + author
        self.imageView.kf.setImage(with: URL(string: imageUrl))
        self.publishedTime.text = publishedTime
    }

    private func setupLayout() {
        addSubview(imageView)
        addSubview(title)
        addSubview(author)
        addSubview(publishedTime)

        NSLayoutConstraint.activate([
            imageView.topAnchor.constraint(equalTo: topAnchor),
            imageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            imageView.bottomAnchor.constraint(equalTo: bottomAnchor),
            imageView.widthAnchor.constraint(equalToConstant: 100),

            title.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            title.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            author.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 5),
            author.leadingAnchor.constraint(equalTo: imageView.trailingAnchor, constant: 10),
            author.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),

            publishedTime.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -15),
            publishedTime.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -5)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
