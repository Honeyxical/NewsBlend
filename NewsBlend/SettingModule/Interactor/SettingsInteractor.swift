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
        let sourcesFromCahce = Converter.decodeSourceObjects(data: dataService.getSources())
        Parser.parseSource(network: networkService) { sourcesFromNetwork in
            if sourcesFromNetwork.isEmpty {
                self.output?.didReceive(sources: sourcesFromCahce)
            } else {
                self.output?.didReceive(sources: Converter.combiningSourceResults(storage: sourcesFromCahce,
                                                                                  network: sourcesFromNetwork))
            }
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
