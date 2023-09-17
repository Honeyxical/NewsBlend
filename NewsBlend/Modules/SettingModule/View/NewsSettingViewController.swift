//  Created by илья on 09.08.23.

import Foundation
import UIKit

enum UpdateIntervals: Int, CaseIterable {
    case oneMin = 60
    case threeMin = 180
    case fiveMin = 300
    case tenMin = 600
    case fiveTeenMin = 1900

    var stringValue: String {
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

final class NewsSettingViewController: UIViewController {
    var output: SettingsViewOutputProtocol?
    
    private var sources: [SourceModel] = []
    private var sourcesAreChange = false
    private var selectedItemIndex: Int?
    private var selectedInterval: Int?
    private var newInterval: Int?

    private let loader: UIView

    private lazy var warningAlert: UIAlertController = {
        let alert = UIAlertController(title: "Warning",
                                      message: "The last source cannot be deleted. Select another one to delete this source.",
                                      preferredStyle: .actionSheet)
        let action = UIAlertAction(title: "Ok", style: .default) { _ in
            guard let selectedItemIndex = self.selectedItemIndex else {
                return
            }
            self.sources[selectedItemIndex].isSelected = true
            self.sourcesCollection.reloadData()
        }
        alert.addAction(action)
        return alert
    }()

    private let intervalsLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Select the news update interval: "
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .thin)
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
        label.font = UIFont.systemFont(ofSize: 16.0, weight: .thin)
        label.textColor = .gray
        return label
    }()

    private lazy var sourcesCollection: UICollectionView = {
        let collection = UICollectionView(frame: .zero, collectionViewLayout: collectionLayout())
        collection.translatesAutoresizingMaskIntoConstraints = false
        collection.dataSource = self
        collection.delegate = self
        collection.register(SettingSourceCell.self, forCellWithReuseIdentifier: "cell")
        return collection
    }()

    private lazy var pickerAlert: UIAlertController = {
        let alert = UIAlertController(title: "Warning", message: "Did you want change update interval?", preferredStyle: .actionSheet)
        let confirmAction = UIAlertAction(title: "Yes", style: .default) { _ in
            guard let newInterval = self.newInterval else { return }
            self.selectedInterval = newInterval
            self.output?.setInterval(interval: UpdateIntervals.allCases[newInterval])
        }
        let cancelAction = UIAlertAction(title: "No", style: .cancel) { _ in
            guard let selectedInterval = self.selectedInterval, let intervalValue = UpdateIntervals(rawValue: selectedInterval) else { return }
            self.pickerView.selectRow(UpdateIntervals.allCases.firstIndex(of: intervalValue) ?? 0, inComponent: 0, animated: true)
        }
        alert.addAction(confirmAction)
        alert.addAction(cancelAction)
        return alert
    }()

    init(loader: UIView) {
        self.loader = loader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupLayout()
        output?.viewDidLoad()
        title = "News Settings"
        view.backgroundColor = .white
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        if sourcesAreChange {
            let prevVC = navigationController?.viewControllers[0] as? FeedViewController
            prevVC?.updateNBSSources()
        }
    }
}

extension NewsSettingViewController {
    private func setupLayout() {
        view.addSubview(intervalsLabel)
        view.addSubview(pickerView)
        view.addSubview(sourcesLabel)
        view.addSubview(sourcesCollection)
        view.addSubview(loader)

        let horizontalOffset = 16.0
        let topOffset = 12.0

        NSLayoutConstraint.activate([
            intervalsLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalOffset),
            intervalsLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topOffset),
            intervalsLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalOffset),

            pickerView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalOffset),
            pickerView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -horizontalOffset),
            pickerView.topAnchor.constraint(equalTo: intervalsLabel.bottomAnchor),
            pickerView.heightAnchor.constraint(equalToConstant: 100.0),

            sourcesLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: horizontalOffset),
            sourcesLabel.topAnchor.constraint(equalTo: pickerView.bottomAnchor, constant: topOffset),

            sourcesCollection.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            sourcesCollection.topAnchor.constraint(equalTo: sourcesLabel.bottomAnchor, constant: topOffset),
            sourcesCollection.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            sourcesCollection.bottomAnchor.constraint(equalTo: view.bottomAnchor),

            loader.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            loader.topAnchor.constraint(equalTo: view.topAnchor),
            loader.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            loader.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }

    private func collectionLayout() -> UICollectionViewFlowLayout {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .vertical
        layout.itemSize = CGSize(width: view.bounds.width / 2.5, height: 48.0)
        layout.minimumInteritemSpacing = 20.0
        layout.minimumLineSpacing = 26.0
        layout.sectionInset = UIEdgeInsets(top: 0.0, left: 24.0, bottom: 0.0, right: 24.0)
        return layout
    }
}

extension NewsSettingViewController: SettingsViewInputProtocol {
    func set(interval: Int) {
        let intervalValue = UpdateIntervals(rawValue: interval) ?? .tenMin
        selectedInterval = interval
        pickerView.selectRow(UpdateIntervals.allCases.firstIndex(of: intervalValue) ?? 0, inComponent: 0, animated: true)
    }

    func set(source: [SourceModel]) {
        self.sources = source
        sourcesCollection.reloadData()
    }

    func loaderIsHidden(_ state: Bool) {
        loader.isHidden = state
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
        UpdateIntervals.allCases[row].stringValue
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        newInterval = row
        self.present(pickerAlert, animated: true)
    }
}

// MARK: Collection Delegate / DataSource

extension NewsSettingViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        sources.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? SettingSourceCell else {
            return UICollectionViewCell()
        }

        cell.setSourceName(name: sources[indexPath.item].name, isSelected: sources[indexPath.item].isSelected)
        return cell
    }

    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if sources[indexPath.item].isSelected == false {
            sourcesAreChange = true
            sources[indexPath.item].isSelected = true
            output?.setFollowedSource(source: sources[indexPath.item])
            collectionView.reloadData()
        } else {
            output?.deleteFollowedSource(source: sources[indexPath.item])
            sourcesAreChange = true
            sources[indexPath.item].isSelected = false
            selectedItemIndex = indexPath.item
            collectionView.reloadData()
        }
    }
}
