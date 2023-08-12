//  Created by илья on 01.08.23.

import Foundation

class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    let settingsDataService: SettingsCoreDataServiceProtocol
    let settingNetworkService: SettingNetworkServiceProtocol

    init(settingsDataService: SettingsCoreDataServiceProtocol, settingNetworkService: SettingNetworkServiceProtocol) {
        self.settingNetworkService = settingNetworkService
        self.settingsDataService = settingsDataService
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
    func getAllSources() {
        settingNetworkService.getEngSources { data in
            guard let engSources = try? JSONDecoder().decode(SourcesModel.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            self.output?.didReceive(sources: engSources.sources)
        }
    }
}
