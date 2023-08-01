//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedViewController: UIViewController {
    var output: FeedViewOutputProtocol?
    private var articles: [Articles] = []

    private lazy var newsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FeedCellView.self, forCellWithReuseIdentifier: "Item")
        collection.dataSource = self
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.loadData()
    }

    private func setupLayout() {
        view.addSubview(newsCollection)

        NSLayoutConstraint.activate([
            newsCollection.topAnchor.constraint(equalTo: view.topAnchor),
            newsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? FeedCellView else {
            return UICollectionViewCell()
        }
        cell.setData(title: articles[indexPath.item].title, shortDescription: articles[indexPath.item].description)
        return cell
    }

    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: 100)
        layout.minimumLineSpacing = 20
        return layout
    }
}

extension FeedViewController: FeedViewInputProtocol {
    func set(articles: [Articles]) {
        self.articles = articles
    }

    func reloadData() {
        newsCollection.reloadData()
    }

    func showLoader() {

    }

    func hideLoader() {

    }
}
