//  Created by илья on 01.08.23.

import Foundation

class SettingsPresentor {
    let view: SettingsViewInputProtocol
    let interactor: SettingsInteractorInputProtocol
    let router: SettingsRouterInputProtocol

    init(view: SettingsViewInputProtocol, interactor: SettingsInteractorInputProtocol, router: SettingsRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension SettingsPresentor: SettingsViewOutputProtocol {

}

extension SettingsPresentor: SettingsInteractorOutputProtocol {

}

extension SettingsPresentor: SettingsRouterOutputProtocol {

}
