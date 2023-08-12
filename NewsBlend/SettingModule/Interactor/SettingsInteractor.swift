//  Created by илья on 01.08.23.

import Foundation

class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    let dataService: SettingsDBServiceProtocol
    let networkService: SettingNetworkServiceProtocol

    init(settingsDataService: SettingsDBServiceProtocol, settingNetworkService: SettingNetworkServiceProtocol) {
        self.networkService = settingNetworkService
        self.dataService = settingsDataService
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
    func getAllSources() {
        networkService.getEngSources { data in
            guard let engSources = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            self.output?.didReceive(sources: self.transferObject(sources: engSources.sources))
        }
    }

    func getIntervals() {
        output?.didReceive(interval: dataService.getUpdateInterval())
    }

    func getFollowedSources() {

    }

    func setInterval(interval: Int) {
        dataService.setUpdateUnterval(interval: interval)
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
