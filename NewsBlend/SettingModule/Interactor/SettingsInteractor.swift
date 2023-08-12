//  Created by илья on 01.08.23.

import Foundation

class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    let settingsDataService: SettingsDBServiceProtocol
    let settingNetworkService: SettingNetworkServiceProtocol

    init(settingsDataService: SettingsDBServiceProtocol, settingNetworkService: SettingNetworkServiceProtocol) {
        self.settingNetworkService = settingNetworkService
        self.settingsDataService = settingsDataService
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
    func getAllSources() {
        settingNetworkService.getEngSources { data in
            guard let engSources = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            self.output?.didReceive(sources: self.transferObject(sources: engSources.sources))
        }
    }
}

extension SettingsInteractor {
    private func transferObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }
}
