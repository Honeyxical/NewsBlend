//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedViewController: UIViewController {
    var output: FeedViewOutputProtocol?
    private lazy var breakingNewsVC = BreakingNewsView() // Need to remove strong link
    private var articles: [Articles] = []

    private let sectionName: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Trending News"
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        return title
    }()

    private lazy var newsCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.register(FeedCellView.self, forCellWithReuseIdentifier: "Item")
        collection.dataSource = self
        collection.showsVerticalScrollIndicator = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        addChildVC()
        setupLayout()
        configuringNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.loadData()
        output?.loadHotData()
    }

    private func addChildVC() {
        addChild(breakingNewsVC)
        view.addSubview(breakingNewsVC.view)
        breakingNewsVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            breakingNewsVC.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            breakingNewsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breakingNewsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breakingNewsVC.view.heightAnchor.constraint(equalToConstant: view.frame.height / 3)
        ])
    }

    private func configuringNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }

    private func setupLayout() {
        view.addSubview(newsCollection)
        view.addSubview(sectionName)

        NSLayoutConstraint.activate([
            sectionName.topAnchor.constraint(equalTo: breakingNewsVC.view.bottomAnchor, constant: 30),
            sectionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

            newsCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 15),
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
        cell.setData(title: articles[indexPath.item].title,
                     author: articles[indexPath.item].author ?? "",
                     imageUrl: articles[indexPath.item].urlToImage,
                     publishedTime: articles[indexPath.item].publishedAt)
        return cell
    }

    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width - 20, height: 130)
        layout.minimumLineSpacing = 15
        return layout
    }
}

extension FeedViewController: FeedViewInputProtocol {
    func set(hot articles: [Articles]) {
        breakingNewsVC.setData(articles: articles)
    }

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

    func displayLotty() {
        let lotty = UILabel()
        lotty.translatesAutoresizingMaskIntoConstraints = false
        lotty.text = "Fail get data"
        lotty.font = UIFont.systemFont(ofSize: 36)

        newsCollection.removeFromSuperview()
        sectionName.removeFromSuperview()
        breakingNewsVC.view.removeFromSuperview()

        view.addSubview(lotty)

        lotty.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        lotty.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
    }
}
