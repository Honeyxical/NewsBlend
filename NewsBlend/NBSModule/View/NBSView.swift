//  Created by илья on 13.08.23.

import Foundation
import UIKit

class NBSView: UIViewController {
    var output: NBSViewOutputProtocol?
    private var sources: [SourceModel] = []
    private var articles: [ArticleModel] = []

    private let sectionName: UILabel = {
        let label = UILabel()
        label.text = "News"
        label.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private lazy var sourcesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionSourcesLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(SourcesCell.self, forCellWithReuseIdentifier: "sourceCell")
        collection.showsHorizontalScrollIndicator = false
        return collection
    }()

    private lazy var articlesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionArticlesLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(ArticleCell.self, forCellWithReuseIdentifier: "articleCell")
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewDidAppear()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        output?.viewDidAppear()
        setupLayout()
    }
}

extension NBSView: NBSViewInputProtocol {
    func reloadData() {
        articlesCollection.reloadData()
        sourcesCollection.reloadData()
    }

    func set(sources: [SourceModel]) {
        self.sources = []
        self.sources += [SourceModel(id: "",
                                     name: "All",
                                     category: "",
                                     language: "",
                                     country: "")]
        self.sources += sources
        sourcesCollection.reloadData()
    }

    func showLoader() {

    }

    func hideLoader() {

    }

    func displayLotty() {
        
    }
}

extension NBSView: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == sourcesCollection {
            return sources.count
        } else {
            return articles.count
        }
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView {
        case sourcesCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sourceCell", for: indexPath) as? SourcesCell else {
                return UICollectionViewCell()
            }
            cell.setSourceName(name: sources[indexPath.item].name)
            return cell
        case articlesCollection:
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleCell else {
                return UICollectionViewCell()
            }
            cell.setData(title: articles[indexPath.item].title,
                         author: articles[indexPath.item].author,
                         imageUrl: articles[indexPath.item].urlToImage,
                         publishedTime: articles[indexPath.item].timeSincePublication)
            return cell
        default:
            return UICollectionViewCell()
        }
    }

    private func collectionSourcesLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        return layout
    }

    private func collectionArticlesLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width - 30, height: 100)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        return layout
    }
}

extension NBSView {
    private func setupLayout() {
        view.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(sectionName)
        view.addSubview(sourcesCollection)
        view.addSubview(articlesCollection)

        NSLayoutConstraint.activate([
            sectionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sectionName.topAnchor.constraint(equalTo: view.topAnchor),

            sourcesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 10),
            sourcesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollection.heightAnchor.constraint(equalToConstant: 50),

            articlesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articlesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articlesCollection.topAnchor.constraint(equalTo: sourcesCollection.bottomAnchor, constant: 15),
            articlesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}
