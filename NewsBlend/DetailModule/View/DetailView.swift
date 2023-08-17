//  Created by илья on 03.08.23.

import Foundation
import Kingfisher
import UIKit

class DetailView: UIViewController {
    var output: DetailViewOutputProtocol?
    private lazy var loader = ReusableViews.getLoader(view: view)
    private lazy var contentRect: CGRect = scrollView.subviews.reduce(into: .zero) { rect, view in
        rect = rect.union(view.frame)
    }

    private lazy var scrollView: UIScrollView = {
        let view = UIScrollView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.showsVerticalScrollIndicator = false
        view.backgroundColor = .white
        return view
    }()

    private lazy var imageView: UIImageView = {
        let view = UIImageView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.contentMode = .scaleAspectFill
        return view
    }()

    private let author: UILabel = {
        let author = UILabel()
        author.translatesAutoresizingMaskIntoConstraints = false
        author.font = UIFont.systemFont(ofSize: 14)
        author.textColor = .gray
        author.numberOfLines = 2
        return author
    }()

    private let publishedAt: UILabel = {
        let publisheAt = UILabel()
        publisheAt.translatesAutoresizingMaskIntoConstraints = false
        publisheAt.font = UIFont.systemFont(ofSize: 12)
        return publisheAt
    }()

    private let articleTitle: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.font = UIFont(name: "AppleSDGothicNeo-SemiBold", size: 24)
        title.numberOfLines = 0
        return title
    }()

    private lazy var tagStack: UIStackView = {
        let stack = UIStackView(arrangedSubviews: [self.tag])
        stack.translatesAutoresizingMaskIntoConstraints = false
        return stack
    }()

    private let tag: UILabel = {
        let tag = UILabel()
        tag.translatesAutoresizingMaskIntoConstraints = false
        tag.font = UIFont.systemFont(ofSize: 12, weight: .thin)
        tag.text = "\u{1F525} Trending news"
        return tag
    }()

    private let content: UILabel = {
        let content = UILabel()
        content.translatesAutoresizingMaskIntoConstraints = false
        content.numberOfLines = 0
        return content
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        showLoader()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        scrollView.contentSize = contentRect.size
        output?.viewDidAppear()
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

extension DetailView: DetailViewInputProtocol {
    func set(article: ArticleModel) {
        self.imageView.kf.setImage(with: URL(string: article.urlToImage))
        self.articleTitle.text = article.title
        self.content.text = article.content
        self.author.text = "By \(article.author)"
        self.publishedAt.text = article.timeSincePublication
    }

    func showLoader() {
        view.addSubview(loader)
        setupLoaderLayout()
    }

    func hideLoader() {
        loader.removeFromSuperview()
        setupLayout()
        setupScrollView()
    }

    func displayLotty() {
    }
}

extension DetailView {
    private func setupScrollView() {
        scrollView.addSubview(imageView)
        scrollView.addSubview(author)
        scrollView.addSubview(publishedAt)
        scrollView.addSubview(articleTitle)
        scrollView.addSubview(tagStack)
        scrollView.addSubview(content)

        NSLayoutConstraint.activate([
            imageView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            imageView.topAnchor.constraint(equalTo: scrollView.topAnchor),
            imageView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            imageView.heightAnchor.constraint(equalToConstant: 350),

            author.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            author.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            author.widthAnchor.constraint(equalToConstant: 300),

            publishedAt.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            publishedAt.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            articleTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            articleTitle.topAnchor.constraint(equalTo: author.bottomAnchor, constant: 20),
            articleTitle.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            tagStack.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            tagStack.topAnchor.constraint(equalTo: articleTitle.bottomAnchor, constant: 20),
            tagStack.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),

            content.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            content.topAnchor.constraint(equalTo: tagStack.bottomAnchor, constant: 20),
            content.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }

    private func setupLoaderLayout() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}
