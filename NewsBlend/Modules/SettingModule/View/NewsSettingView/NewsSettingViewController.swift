//  Created by илья on 09.08.23.

import Foundation
import UIKit

enum UpdateIntervals: Int, CaseIterable {
    case oneMin = 60
    case threeMin = 180
    case fiveMin = 300
    case tenMin = 600
    case fiveTeenMin = 1900

    func stringValue() -> String {
        switch self {
        case .oneMin:
            return "1 min"
        case .threeMin:
            return "3 min"
        case .fiveMin:
            return "5 min"
        case .tenMin:
            return "10 min"
        case .fiveTeenMin:
            return "15 min"
        }
    }
}

protocol UpdateSourceProtocol: AnyObject {
    func sourcesAreChanged(newSources: [SourceModel])
}

final class NewsSettingViewController: UIViewController {
    var output: SettingsViewOutputProtocol?
    weak var delegate: UpdateSourceProtocol?
    private var sources: [SourceModel] = []
    private var sourcesAreChange = false
    private var addedSources: [SourceModel] = []

    private lazy var loader: UIView = {
        let loader = Loader().getLoader()
        loader.backgroundColor = .white
        return loader
    }()

    private let warningAlert: UIAlertController = {
        let alert = UIAlertController(title: "Warning",
                                      message: "The last source cannot be deleted. Select another one to delete this source.",
                                      preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "Ok", style: .default))
        return alert
    }()

    private let intervalsLabel: UILabel = {
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
        setupLayout()
        output?.viewDidLoad()
        title = "News Settings"
        view.backgroundColor = .white
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        if sourcesAreChange {
            delegate?.sourcesAreChanged(newSources: addedSources)
        }
    }
}

extension NewsSettingViewController {
    private func setupLayout() {
        view.addSubview(intervalsLabel)
        view.addSubview(pickerView)
        view.addSubview(sourcesLabel)
        view.addSubview(sourcesCollection)

        NSLayoutConstraint.activate([
            intervalsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            intervalsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 15),
            intervalsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -15),

            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -25),
            pickerView.topAnchor.constraint(equalTo: intervalsLabel.bottomAnchor, constant: 0),
            pickerView.heightAnchor.constraint(equalToConstant: 100),

            sourcesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 15),
            sourcesLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: 15),

            sourcesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollection.topAnchor.constraint(equalTo: sourcesLabel.bottomAnchor, constant: 15),
            sourcesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.frame.width / 2.5, height: 50)
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 20
        layout.minimumLineSpacing = 25
        layout.sectionInset = UIEdgeInsets(top: 0, left: 25, bottom: 0, right: 25)
        return layout
    }

    private func setupLoaderLayout() {
        NSLayoutConstraint.activate([
            loader.heightAnchor.constraint(equalToConstant: view.frame.height),
            loader.widthAnchor.constraint(equalToConstant: view.frame.width),
            loader.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
    }
}

extension NewsSettingViewController: SettingsViewInputProtocol {
    func set(interval: Int) {
        let intervalValue = UpdateIntervals(rawValue: interval) ?? .tenMin
        pickerView.selectRow(UpdateIntervals.allCases.firstIndex(of: intervalValue) ?? 0, inComponent: 0, animated: true)
    }

    func set(source: [SourceModel]) {
        self.sources = source
    }

    func showLoader() {
        if loader.isHidden {
            loader.isHidden = false
        } else {
            view.addSubview(loader)
            setupLoaderLayout()
        }
    }

    func hideLoader() {
        loader.isHidden = true
        sourcesCollection.reloadData()
    }

    func displayAlert() {
        self.present(warningAlert, animated: true)
    }
}

// MARK: Picker Delegate / DataSource

extension NewsSettingViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        UpdateIntervals.allCases.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        UpdateIntervals.allCases[row].stringValue()
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        output?.setInterval(interval: UpdateIntervals.allCases[row])
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
            sourcesAreChange = true
            sources[indexPath.item].isSelected = true
            addedSources.append(sources[indexPath.item])
            output?.setFollowedSource(source: sources[indexPath.item])
            collectionView.reloadData()
        } else {
            output?.deleteFollowedSource(source: sources[indexPath.item])
            sourcesAreChange = true
            sources[indexPath.item].isSelected = false
            collectionView.reloadData()
        }
    }
}
