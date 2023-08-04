//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedViewController: UIViewController {
    var output: FeedViewOutputProtocol?
    private lazy var breakingNewsVC = BreakingNewsView() // Need to remove strong link
    private var articles: [Article] = []

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1025)
        return scrollView
    }()

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
        collection.delegate = self
        collection.showsVerticalScrollIndicator = false
        collection.isScrollEnabled = false
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
        configuringNavigationBar()
        addChild(breakingNewsVC)
        breakingNewsVC.view.translatesAutoresizingMaskIntoConstraints = false
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.loadData()
        output?.loadHotData()
        breakingNewsVC.output = output
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

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.openArticleDetail(article: articles[indexPath.item])
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
    func set(hot articles: [Article]) {
        breakingNewsVC.setData(articles: articles)
    }

    func set(articles: [Article]) {
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

extension FeedViewController {
    private func configuringNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(image: UIImage(systemName: "gearshape"),
                                                            style: .plain,
                                                            target: self,
                                                            action: nil)
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(breakingNewsVC.view)
        scrollView.addSubview(newsCollection)
        scrollView.addSubview(sectionName)

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            breakingNewsVC.view.topAnchor.constraint(equalTo: scrollView.topAnchor),
            breakingNewsVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            breakingNewsVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            breakingNewsVC.view.heightAnchor.constraint(equalToConstant: view.frame.height / 3),

            sectionName.topAnchor.constraint(equalTo: breakingNewsVC.view.bottomAnchor, constant: 30),
            sectionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

            newsCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor, constant: 15),
            newsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            newsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            newsCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: -30)
        ])
    }
}

extension FeedViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if scrollView.contentOffset.y > 205 {
            newsCollection.isScrollEnabled = true
        } else {
            newsCollection.isScrollEnabled = false
        }
    }
}
