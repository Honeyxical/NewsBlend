//  Created by илья on 03.08.23.

import Foundation
import UIKit

class BreakingNewsView: UIViewController {
    var output: FeedViewOutputProtocol?
    private var articles: [Article] = []

    private let sectionName: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Breaking News"
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .systemBlue
        return title
    }()

    private lazy var collection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(TrendingCell.self, forCellWithReuseIdentifier: "Item")
        collection.dataSource = self
        collection.delegate = self
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        setupLayout()
    }

    private func setupLayout() {
        view.addSubview(sectionName)
        view.addSubview(collection)

        NSLayoutConstraint.activate([
            sectionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sectionName.topAnchor.constraint(equalTo: view.topAnchor),
            sectionName.heightAnchor.constraint(equalToConstant: 25),

            collection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            collection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 10),
            collection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            collection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}

extension BreakingNewsView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? TrendingCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: articles[indexPath.item].title, publishedTime: articles[indexPath.item].publishedAt, imageUrl: articles[indexPath.item].urlToImage)

        return cell
    }

    private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.bounds.width - 50, height: view.frame.height / 3.5)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        return layout
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.openArticleDetail(article: articles[indexPath.item])
        print("Selected item: \(indexPath.item)")
    }

    func setData(articles: [Article]) {
        self.articles = articles
        reloadData()
    }

    func reloadData() {
        self.collection.reloadData()
    }

}
