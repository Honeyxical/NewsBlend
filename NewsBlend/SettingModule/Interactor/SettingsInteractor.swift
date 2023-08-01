//  Created by илья on 01.08.23.

import Foundation

class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    let settingsDataService: SettingsCoreDataServiceProtocol

    init(settingsDataService: SettingsCoreDataServiceProtocol) {
        self.settingsDataService = settingsDataService
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {

}
