//  Created by илья on 03.08.23.

import Foundation
import Kingfisher
import UIKit

final class DetailViewController: UIViewController {
    var output: DetailViewOutputProtocol?
    private lazy var contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
        rect = rect.union(view.frame)
    }

    private let scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()

    private let imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let authorLabel: UILabel = {
        let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.systemFont(ofSize: 14)
        author.textColor = .gray
        author.numberOfLines = 2
        return author
    }()

    private let publishedAtLabel: UILabel = {
        let publisheAt = UILabel()
        publisheAt.translatesAutoresizingMaskIntoConstraints = false
        publisheAt.font = UIFont.systemFont(ofSize: 12)
        return publisheAt
    }()

    private let articleTitleLabel: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
        title.numberOfLines = 0
        return title
    }()

    private lazy var tagStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.tagLabel])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let tagLabel: UILabel = {
        let tag = UILabel()
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        tag.text = "\u{1F525} Trending news"
        return tag
    }()

    private let contentLabel: UILabel = {
        let content = UILabel()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        return content
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        output?.viewDidLoad()
        setupLayout()
        setupScrollView()
        scrollView.contentSize = contentRect.size
    }

    func setupLayout() {
        view.addSubview(scrollView)
        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension DetailViewController: DetailViewInputProtocol {
    func setArticle(article: ArticleModel) {
        imageView.kf.setImage(with: URL(string: article.urlToImage))
        articleTitleLabel.text = article.title
        contentLabel.text = article.content
        authorLabel.text = "By \(article.author)"
        publishedAtLabel.text = article.timeSincePublication
    }
}

extension DetailViewController {
    private func setupScrollView() {
        scrollView.addSubview(imageView)
        scrollView.addSubview(authorLabel)
        scrollView.addSubview(publishedAtLabel)
        scrollView.addSubview(articleTitleLabel)
        scrollView.addSubview(tagStack)
        scrollView.addSubview(contentLabel)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: -100),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 400),

            authorLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            authorLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            authorLabel.widthAnchor.constraint(equalToConstant: 300),

            publishedAtLabel.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            publishedAtLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            articleTitleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            articleTitleLabel.topAnchor.constraint(equalTo: authorLabel.bottomAnchor, constant: 20),
            articleTitleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            tagStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tagStack.topAnchor.constraint(equalTo: articleTitleLabel.bottomAnchor, constant: 20),
            tagStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            contentLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            contentLabel.topAnchor.constraint(equalTo: tagStack.bottomAnchor, constant: 20),
            contentLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

}
