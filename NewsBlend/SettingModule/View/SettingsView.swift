//  Created by илья on 01.08.23.

import Foundation
import UIKit

class SettingsView: UIViewController {
    var output: SettingsViewOutputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .green
    }
}

extension SettingsView: SettingsViewInputProtocol {
    func set() {

    }

    func reloadData() {

    }

    func showLoader() {

    }

    func hideLoader() {

    }
}
