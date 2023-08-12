//  Created by илья on 01.08.23.

import Foundation
import UIKit

class SettingsView: UIViewController {
    var output: SettingsViewOutputProtocol?
    var newsSettingView: SettingsViewInputProtocol?

    private let sections = ["Profile", "Security", "News"]
    private let sectionProfile = ["Personal data", "Notification"]
    private let sectionSecurity = ["Password"]
    private let sectionNews = ["News sources"]

    private let screenTitle: UILabel = {
        let label = UILabel()
        label.text = "Settings"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textColor = .systemBlue
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()

    private let userView: UIView = {
        let view = UIView()
        let label = UILabel(frame: CGRect(x: 125, y: 50, width: 125, height: 100))
        label.text = "Cooming soon"
        view.addSubview(label)
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.borderWidth = 1
        view.layer.borderColor = UIColor.red.cgColor
        return view
    }()

    private lazy var tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.delegate = self
        tableView.dataSource = self
        tableView.separatorStyle = .none
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.rowHeight = 60
        tableView.register(SettingsCell.self, forCellReuseIdentifier: "SettingsCell")
        tableView.backgroundColor = .white
        return tableView
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupLayout()
    }
}

extension SettingsView: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return sectionProfile.count
        } else if section == 1 {
            return sectionSecurity.count
        } else {
            return sectionNews.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SettingsCell", for: indexPath) as? SettingsCell else {
            return UITableViewCell()
        }

        switch indexPath.section {
        case 0:
            cell.setData(title: sectionProfile[indexPath.row])
        case 1:
            cell.setData(title: sectionSecurity[indexPath.row])
        case 2:
            cell.setData(title: sectionNews[indexPath.row])
        default:
            cell.setData(title: "")
        }

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        sections.count
    }

    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: 0))
        let title = UILabel(frame: CGRect(x: 25, y: 0, width: view.frame.width, height: 50))
        title.text = sections[section]
        view.addSubview(title)
        view.backgroundColor = .white
        return view
    }

    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        40
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 2 && indexPath.row == 0 {
            navigationController?.pushViewController(NewsSettingView(), animated: true)
        }
    }
}

extension SettingsView: MenuViewProtocol {
}

extension SettingsView {
    private func setupLayout() {
        view.addSubview(screenTitle)
        view.addSubview(userView)
        view.addSubview(tableView)

        NSLayoutConstraint.activate([
            screenTitle.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 25),
            screenTitle.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 10),

            userView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            userView.topAnchor.constraint(equalTo: screenTitle.bottomAnchor, constant: 15),
            userView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            userView.heightAnchor.constraint(equalToConstant: 200),

            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.topAnchor.constraint(equalTo: userView.bottomAnchor, constant: 15),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
}
