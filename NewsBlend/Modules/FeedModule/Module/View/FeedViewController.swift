//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedViewController: UIViewController {
    var output: FeedViewOutputProtocol?
    private let childViewVC: UIViewController
    private let lottieChildView: UIView
    private var articles: [PresenterModel] = []
    private let loader: UIView

    private lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.delegate = self
        scrollView.contentSize = CGSize(width: view.frame.width, height: 1060)
        return scrollView
    }()

    private let sectionNameLabel: UILabel = {
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
        view.backgroundColor = .systemBackground
        configuringNavigationBar()
        output?.viewDidLoad()
        setupLayout()
    }

    init(childView: UIViewController, lottieChildView: UIView, loader: UIView) {
        self.childViewVC = childView
        self.lottieChildView = lottieChildView
        self.loader = loader
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension FeedViewController: UICollectionViewDelegate {
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

extension FeedViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        articles.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "Item", for: indexPath) as? TrendingCell else {
            return UICollectionViewCell()
        }
        cell.setData(title: articles[indexPath.item].title, timeSincePublication: articles[indexPath.item].publishedAt, imageUrl: articles[indexPath.item].urlToImage)
        return cell
    }
}

extension FeedViewController: FeedViewInputProtocol {
    func setArticles(articles: [PresenterModel]) {
        self.articles = articles
    }

    func reloadData() {
        hotNewsCollection.reloadData()
        if childViewVC is NBSViewController {
            let childViewVC = childViewVC as? NBSViewController
            childViewVC?.moduleInput?.reloadData()
        }
    }

    func updateNBSSources() {
        if childViewVC is NBSViewController {
            let childViewVC = childViewVC as? NBSViewController
            childViewVC?.moduleInput?.updateSourceAndArticles()
        }
    }

    func showLoader() {
        loader.isHidden = false
    }

    func hideLoader() {
        loader.isHidden = true
    }

    func displayLottie() {
        lottieChildView.isHidden = false
        loader.isHidden = true
    }

    func hideLottie() {
        lottieChildView.isHidden = true
    }
}

extension FeedViewController: LottieUnknownErrorDelegate {
    func reloadPage() {
        output?.reloadData()
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
        addChild(childViewVC)
        view.addSubview(scrollView)
        scrollView.addSubview(childViewVC.view)
        scrollView.addSubview(hotNewsCollection)
        scrollView.addSubview(sectionNameLabel)
        scrollView.addSubview(lottieChildView)
        scrollView.addSubview(loader)
        childViewVC.view.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            scrollView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            scrollView.topAnchor.constraint(equalTo: view.topAnchor),
            scrollView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            sectionNameLabel.topAnchor.constraint(equalTo: scrollView.topAnchor),
            sectionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),

            hotNewsCollection.topAnchor.constraint(equalTo: sectionNameLabel.bottomAnchor),
            hotNewsCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            hotNewsCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            hotNewsCollection.heightAnchor.constraint(equalToConstant: view.frame.height / 3),

            childViewVC.view.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childViewVC.view.topAnchor.constraint(equalTo: hotNewsCollection.bottomAnchor),
            childViewVC.view.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childViewVC.view.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 16),
            childViewVC.view.widthAnchor.constraint(equalToConstant: view.frame.width),

            lottieChildView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            lottieChildView.topAnchor.constraint(equalTo: view.topAnchor),
            lottieChildView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            lottieChildView.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.topAnchor.constraint(equalTo: view.topAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
