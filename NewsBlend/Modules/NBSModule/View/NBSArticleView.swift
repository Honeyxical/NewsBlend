//  Created by илья on 13.09.23.

import UIKit

protocol DidTapProtocol: AnyObject {
    func didTap(article: ArticleModel)
}

final class NBSArticleView: UIView {
    weak var delegate: DidTapProtocol?
    private var articles: [ArticleModel] = []
    private var isShortCell = true

    private lazy var articlesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionArticlesLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ArticleShortCell.self, forCellWithReuseIdentifier: "articleShortCell")
        collection.register(ArticleFullCell.self, forCellWithReuseIdentifier: "articleFullCell")
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NBSArticleView {
    func setArticle(articles: [ArticleModel], cellType: Bool){
        self.articles = articles
        articlesCollection.reloadData()
        isShortCell = cellType
    }

    func reloadView() {
        articlesCollection.reloadData()
    }

    private func collectionArticlesLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: 400, height: 130)
//        layout.itemSize = CGSize(width: frame.width, height: 100)
        layout.minimumLineSpacing = 15
        return layout
    }

    private func setupLayout() {
        addSubview(articlesCollection)

        NSLayoutConstraint.activate([
            articlesCollection.leadingAnchor.constraint(equalTo: leadingAnchor),
            articlesCollection.topAnchor.constraint(equalTo: topAnchor),
            articlesCollection.trailingAnchor.constraint(equalTo: trailingAnchor),
            articlesCollection.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
    }
}

extension NBSArticleView: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        delegate?.didTap(article: articles[indexPath.item])
    }
}

extension NBSArticleView: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if isShortCell {
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleShortCell", for: indexPath) as? ArticleShortCell else {
                return UICollectionViewCell()
            }
            cell.setData(article: articles[indexPath.row])
            return cell
        }
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleFullCell", for: indexPath) as? ArticleFullCell else {
            return UICollectionViewCell()
        }
        cell.setData(article: articles[indexPath.row])
        return cell
    }

}
