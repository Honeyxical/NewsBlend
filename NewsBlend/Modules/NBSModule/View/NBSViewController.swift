//  Created by илья on 13.08.23.

import Foundation
import UIKit

final class NBSViewController: UIViewController {
    var output: NBSViewOutputProtocol?
    private var sources: [SourceModel] = []

    private lazy var loader = ReusableViews.getLoader()

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
        collection.register(ArticleBySourceCell.self, forCellWithReuseIdentifier: "articleCell")
        collection.showsVerticalScrollIndicator = false
        collection.showsHorizontalScrollIndicator = false
        collection.isPagingEnabled = true
        return collection
    }()

    private lazy var cellType: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        button.setTitle("Full", for: .normal)
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(changeViewMode), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }
}

extension NBSViewController: NBSViewInputProtocol {
    func setSources(sources: [SourceModel]) {
        self.sources = sources
        sourcesCollection.reloadData()
    }

    func setArticle(articles: [ArticleModel]) {
        let cell = articlesCollection.cellForItem(at: articlesCollection.indexPathsForVisibleItems.first ?? IndexPath()) as? ArticleBySourceCell
        guard let output = output else { return }
        cell?.setArticle(articles: articles, output: output, controller: self)
    }

    func showLoader() {
        if loader.isHidden {
            loader.isHidden = false
        } else {
            view.addSubview(loader)
        }
    }

    func hideLoader() {
        loader.isHidden = true
    }
}

extension NBSViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sources.count
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
            guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "articleCell", for: indexPath) as? ArticleBySourceCell else {
                return UICollectionViewCell()
            }
            output?.getArticlesBySource(source: sources[indexPath.item])
            return cell

        default:
            return UICollectionViewCell()
        }
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        articlesCollection.scrollToItem(at: indexPath,
                                        at: .centeredHorizontally,
                                        animated: true)
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
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width, height: 650)
        layout.minimumLineSpacing = 0
        return layout
    }
}

extension NBSViewController {
    private func setupLayout() {
        view.addSubview(sectionName)
        view.addSubview(cellType)
        view.addSubview(sourcesCollection)
        view.addSubview(articlesCollection)

        NSLayoutConstraint.activate([
            sectionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sectionName.topAnchor.constraint(equalTo: view.topAnchor),

            cellType.topAnchor.constraint(equalTo: view.topAnchor),
            cellType.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            cellType.heightAnchor.constraint(equalToConstant: 25),
            cellType.widthAnchor.constraint(equalToConstant: 45),

            sourcesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 10),
            sourcesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollection.heightAnchor.constraint(equalToConstant: 50),

            articlesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            articlesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            articlesCollection.topAnchor.constraint(equalTo: sourcesCollection.bottomAnchor, constant: 15),
            articlesCollection.heightAnchor.constraint(equalToConstant: 650)
        ])
    }

    @objc private func changeViewMode() {
        guard let cell = articlesCollection.visibleCells.first as? ArticleBySourceCell else {
            return
        }
        if cell.isDefaultCell == true {
            cellType.setTitle("Short", for: .normal)
            cell.changeCellView(isDefaultCell: false)
        } else {
            cellType.setTitle("Full", for: .normal)
            cell.changeCellView(isDefaultCell: true)
        }
    }
}
