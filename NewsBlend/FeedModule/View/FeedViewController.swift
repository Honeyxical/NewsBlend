//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedViewController: UIViewController {
    var output: FeedViewOutputProtocol?
    private let childView: UIViewController
    private lazy var loader = ReusableViews.getLoader(view: self.view)
    private var articles: [ArticleModel] = []

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1020)
        return scrollView
    }()

    private let sectionName: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Hot News"
        title.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        title.textColor = .systemBlue
        return title
    }()

    private lazy var hotNewsCollection: UICollectionView = {
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
        configuringNavigationBar()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        addChild(childView)
        output?.viewWillApear()
    }

    init(childView: UIViewController) {
        self.childView = childView
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? TrendingCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: articles[indexPath.item].title, timeSincePublication: articles[indexPath.item].timeSincePublication, imageUrl: articles[indexPath.item].urlToImage)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        output?.openArticleDetail(article: articles[indexPath.item])
    }

    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: view.frame.width - 50, height: view.frame.height / 3.5)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        return layout
    }
}

extension FeedViewController: FeedViewInputProtocol {
    func setData(articles: [ArticleModel], hotArticles: [ArticleModel]) {
        self.articles = articles
    }

    func reloadData() {
        hotNewsCollection.reloadData()
    }

    func showLoader() {
        view.addSubview(loader)
    }

    func hideLoader() {
        loader.removeFromSuperview()
        setupLayout()
    }

    func displayLotty() {
        let lotty = UILabel()
        lotty.translatesAutoresizingMaskIntoConstraints = false
        lotty.text = "Fail get data"
        lotty.font = UIFont.systemFont(ofSize: 36)

        hotNewsCollection.removeFromSuperview()
        sectionName.removeFromSuperview()

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
                                                            action: #selector(openSettings) )
    }

    @objc private func openSettings() {
        output?.openSettings()
    }

    private func setupLayout() {
        view.addSubview(scrollView)
        scrollView.addSubview(childView.view)
        scrollView.addSubview(hotNewsCollection)
        scrollView.addSubview(sectionName)
        childView.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            sectionName.topAnchor.constraint(equalTo: scrollView.topAnchor),
            sectionName.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),

            hotNewsCollection.topAnchor.constraint(equalTo: sectionName.bottomAnchor),
            hotNewsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotNewsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotNewsCollection.heightAnchor.constraint(equalToConstant: view.frame.height / 3),

            childView.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.view.topAnchor.constraint(equalTo: hotNewsCollection.bottomAnchor),
            childView.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 15),
            childView.view.widthAnchor.constraint(equalToConstant: view.frame.width)
        ])
    }
}
