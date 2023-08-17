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
            let sources = Converter.transferSourceObject(sources: engSources.sources)
            self.output?.didReceive(sources: Converter.combiningSourceResults(storage: self.getFollowedSources(), network: sources))
        }
    }

    func getIntervals() {
        output?.didReceive(interval: dataService.getUpdateInterval())
    }

    func getFollowedSources() -> [SourceModel] {
        let unarchive = Converter.decodeSourceObjects(data: dataService.getSources())
        return unarchive
    }

    func setInterval(interval: Int) {
        dataService.setUpdateUnterval(interval: interval)
    }

    func setFollowedSource(source: SourceModel) {
        source.isSelected = source.isSelected == false ? true : false
        var sources = getFollowedSources()
        sources.append(source)
        dataService.setSource(sources: Converter.encodeSourceObjects(sourceModels: sources))
    }

    func deleteFollowedSource(source: SourceModel) {
        var sources = getFollowedSources()
        sources.remove(at: sources.firstIndex(of: source) ?? 0)
        dataService.saveChangedListSources(sources: Converter.encodeSourceObjects(sourceModels: sources))
    }
}
