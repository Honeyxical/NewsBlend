//  Created by илья on 09.08.23.

import Foundation
import UIKit

class NewsSettingViewController: UIViewController {
    var output: SettingsViewOutputProtocol?
    var sources: [SourceModel] = []
    private let updatesIntervals = ["1 min", "3 min", "5 min", "10 min", "15 min"]
    private lazy var loader = ReusableViews.getLoader(view: view)

    private let untervalsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select the news update interval: "
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.textColor = .gray
        return label
    }()

    private lazy var pickerView: UIPickerView = {
        let picker = UIPickerView()
        picker.translatesAutoresizingMaskIntoConstraints = false
        picker.dataSource = self
        picker.delegate = self
        return picker
    }()

    private let sourcesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select news sources: "
        label.font = UIFont.systemFont(ofSize: 16, weight: .thin)
        label.textColor = .gray
        return label
    }()

    private lazy var sourcesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(SourceCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "News Settings"
        view.backgroundColor = .white
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        output?.viewWillAppear()
    }

}

extension NewsSettingViewController {
    private func setupLayout() {
        view.addSubview(untervalsLabel)
        view.addSubview(pickerView)
        view.addSubview(sourcesLabel)
        view.addSubview(sourcesCollection)

        NSLayoutConstraint.activate([
            untervalsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            untervalsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            untervalsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            pickerView.topAnchor.constraint(equalTo: untervalsLabel.bottomAnchor, constant: 0),
            pickerView.heightAnchor.constraint(equalToConstant: 100),

            sourcesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sourcesLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 15),

            sourcesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollection.topAnchor.constraint(equalTo: sourcesLabel.bottomAnchor, constant: 15),
            sourcesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 2.5, height: 50)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        return layout
    }
}

extension NewsSettingViewController: SettingsViewInputProtocol {
    func set(interval: Int) {
        pickerView.selectRow(interval, inComponent: 0, animated: true)
    }

    func displayLotty() {

    }

    func set(source: [SourceModel]) {
        self.sources = source
    }

    func reloadData() {

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
        sourcesCollection.reloadData()
        setupLayout()
    }

}

// MARK: Picker Delegate / DataSource

extension NewsSettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        updatesIntervals.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        updatesIntervals[row]
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        output?.setInterval(interval: row)
    }
}

// MARK: Collection Delegate / DataSource

extension NewsSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sources.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SourceCell else {
            return UICollectionViewCell()
        }

        cell.setSourceName(name: sources[indexPath.item].name, isSelected: sources[indexPath.item].isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sources[indexPath.item].isSelected == false {
            output?.setFollowedSource(source: sources[indexPath.item])
            collectionView.reloadData()
        } else {
            output?.deleteFollowedSource(source: sources[indexPath.item])
            sources[indexPath.item].isSelected = false
            collectionView.reloadData()
        }
    }
}