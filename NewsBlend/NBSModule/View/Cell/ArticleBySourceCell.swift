//  Created by илья on 15.08.23.

import UIKit

class ArticleBySourceCell: UICollectionViewCell {
    var output: NBSViewOutputProtocol?
    private var articles: [ArticleModel] = []
    private lazy var loader = ReusableViews.getLoader(view: self.collection)
    private var controller: UIViewController?

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
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

    func setArticle(articles: [ArticleModel], output: NBSViewOutputProtocol, controller: UIViewController) {
        self.articles = articles
        self.output = output
        self.controller = controller
        setupLayout()
        loader.removeFromSuperview()
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
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: articles[indexPath.item].title,
                     author: articles[indexPath.item].author,
                     imageUrl: articles[indexPath.item].urlToImage,
                     publishedTime: articles[indexPath.item].timeSincePublication)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        guard let controller = controller else { return }
        output?.openArticleDetail(article: articles[indexPath.item], controller: controller)
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
