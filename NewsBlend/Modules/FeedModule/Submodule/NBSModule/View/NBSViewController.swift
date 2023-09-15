//  Created by илья on 13.08.23.

import Foundation
import UIKit

final class NBSViewController: UIViewController {
    var output: NBSViewOutputProtocol?
    private let childView: UIView
    private var sources: [SourceModel] = []
    private var isShortArticleCell = true
    private var lastSelectedIndex = IndexPath(row: 0, section: 0)

    private let sectionNameLabel: UILabel = {
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

    private lazy var cellTypeButton: UIButton = {
        let button = UIButton(type: .system)
        button.restorationIdentifier = "CellTypeButton"
        button.translatesAutoresizingMaskIntoConstraints = false
        button.layer.cornerRadius = 10
        button.layer.borderColor = UIColor.systemBlue.cgColor
        button.layer.borderWidth = 1
        if isShortArticleCell {
            button.setTitle("Full", for: .normal)
        } else {
            button.setTitle("Short", for: .normal)
        }
        button.tintColor = .lightGray
        button.addTarget(self, action: #selector(changeViewMode), for: .touchUpInside)
        return button
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        output?.viewDidLoad()
        setupLayout()
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }

    init(childView: UIView) {
        self.childView = childView
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension NBSViewController: DidTapProtocol {
    func didTap(article: ArticleModel) {
        output?.openArticleDetail(article: article)
    }
}

extension NBSViewController: NBSViewInputProtocol {
    func noInternet() {
        
    }

    func setSources(sources: [SourceModel]) {
        self.sources = sources
        sourcesCollection.reloadData()
    }

    func setArticle(articles: [ArticleModel]) {
        let childView = childView as? NBSArticleView
        childView?.delegate = self
        childView?.setArticle(articles: articles, cellType: isShortArticleCell)
        
    }
}

extension NBSViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sources.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "sourceCell", for: indexPath) as? SourcesCell else {
            return UICollectionViewCell()
        }
        cell.setSourceName(name: sources[indexPath.item].name)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if lastSelectedIndex != indexPath {
            let newCell = collectionView.cellForItem(at: indexPath)
            newCell?.layer.borderColor = UIColor.systemBlue.cgColor
            
            let prevCell = collectionView.cellForItem(at: lastSelectedIndex)
            prevCell?.layer.borderColor = UIColor.lightGray.cgColor
            lastSelectedIndex = indexPath
        }
        collectionView.selectItem(at: indexPath, animated: true, scrollPosition: .centeredHorizontally)
        let selectedSource = sources[indexPath.item]
        output?.getArticlesBySource(source: selectedSource)
    }

    private func collectionSourcesLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 40)
        layout.minimumLineSpacing = 15
        layout.sectionInset = UIEdgeInsets(top: 0, left: 20, bottom: 0, right: 15)
        return layout
    }
}

extension NBSViewController {
    private func setupLayout() {
        view.addSubview(sectionNameLabel)
        view.addSubview(cellTypeButton)
        view.addSubview(sourcesCollection)
        view.addSubview(childView)

        NSLayoutConstraint.activate([
            sectionNameLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sectionNameLabel.topAnchor.constraint(equalTo: view.topAnchor),

            cellTypeButton.topAnchor.constraint(equalTo: view.topAnchor),
            cellTypeButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),
            cellTypeButton.heightAnchor.constraint(equalToConstant: 25),
            cellTypeButton.widthAnchor.constraint(equalToConstant: 45),

            sourcesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollection.topAnchor.constraint(equalTo: sectionNameLabel.bottomAnchor, constant: 10),
            sourcesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollection.heightAnchor.constraint(equalToConstant: 50),

            childView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            childView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            childView.topAnchor.constraint(equalTo: sourcesCollection.bottomAnchor, constant: 15),
            childView.heightAnchor.constraint(equalToConstant: 650)
        ])
    }

    @objc private func changeViewMode() {
        let childView = childView as? NBSArticleView
        if !isShortArticleCell {
            cellTypeButton.setTitle("Full", for: .normal)
            childView?.reloadView()
            isShortArticleCell.toggle()
        } else {
            cellTypeButton.setTitle("Short", for: .normal)
            childView?.reloadView()
            isShortArticleCell.toggle()
        }
    }
}
