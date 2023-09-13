//  Created by илья on 15.08.23.

import UIKit

protocol DidTapProtocol: AnyObject {
    func didTap(article: ArticleModel)
}

final class ArticleBySourceCell: UICollectionViewCell {
    weak var delegate: DidTapProtocol?
    private var articles: [ArticleModel] = []
    private lazy var loader = ReusableViews.getLoader()
    var isDefaultCell = true

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ArticleShortCell.self, forCellWithReuseIdentifier: "shortArticleCell")
        collection.register(ArticleCell.self, forCellWithReuseIdentifier: "articleCell")
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        addSubview(loader)
        setupLoaderLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setArticle(articles: [ArticleModel]) {
        self.articles = articles
        setupLayout()
        loader.removeFromSuperview()
    }

    func changeCellView(isDefaultCell: Bool) {
        self.isDefaultCell = isDefaultCell
        collection.reloadData()
    }

    private func setupLayout() {
        addSubview(collection)

        NSLayoutConstraint.activate([
            collection.leadingAnchor.constraint(equalTo: leadingAnchor),
            collection.topAnchor.constraint(equalTo: topAnchor),
            collection.trailingAnchor.constraint(equalTo: trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension ArticleBySourceCell: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isDefaultCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "shortArticleCell", for: indexPath) as? ArticleShortCell else {
                return UICollectionViewCell()
            }
            cell.setData(articleTitle: articles[indexPath.item].title, articleAuthor: articles[indexPath.item].author, publishedAt: articles[indexPath.item].timeSincePublication)
            return cell
        } else {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell else {
                return UICollectionViewCell()
            }
            cell.setData(title: articles[indexPath.item].title,
                         author: articles[indexPath.item].author,
                         imageUrl: articles[indexPath.item].urlToImage,
                         publishedTime: articles[indexPath.item].timeSincePublication)
            return cell
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTap(article: articles[indexPath.row])
    }

    private func collectionLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: frame.width, height: 120)
        layout.minimumLineSpacing = 15
        return layout
    }
}

extension ArticleBySourceCell {
    private func setupLoaderLayout() {
        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.topAnchor.constraint(equalTo: topAnchor, constant: 150)
        ])
    }
}
