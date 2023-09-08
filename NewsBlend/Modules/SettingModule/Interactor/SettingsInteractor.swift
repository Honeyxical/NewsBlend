//  Created by илья on 01.08.23.

import Foundation

final class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    let cacheService: SettingStorageProtocol
    let networkService: SettingNetworkServiceProtocol
    let parser: ParserProtocol
    let defaultLanguage = "en"

    init(cacheService: SettingStorageProtocol, networkService: SettingNetworkServiceProtocol, parser: ParserProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.parser = parser
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
    func getAllSources() {
        let sourcesFromCahce = Converter.decodeSourceObjects(data: cacheService.getSources())
        parser.parseSource(defaultLanguage: defaultLanguage, network: networkService) { sourcesFromNetwork in
            if sourcesFromNetwork.isEmpty {
                self.output?.didReceive(sources: sourcesFromCahce)
            } else {
                self.output?.didReceive(sources: Converter.combiningSourceResults(storage: sourcesFromCahce,
                                                                                  network: sourcesFromNetwork))
            }
        }
    }

    func getIntervals() {
        output?.didReceive(interval: cacheService.getUpdateInterval())
    }

    func getFollowedSources() -> [SourceModel] {
        let unarchive = Converter.decodeSourceObjects(data: cacheService.getSources())
        return unarchive
    }

    func setInterval(interval: Int) {
        cacheService.setUpdateUnterval(interval: interval)
    }

    func setFollowedSource(source: SourceModel) {
        var source = source
        source.isSelected = source.isSelected == false ? true : false
        var sources = getFollowedSources()
        sources.append(source)
        cacheService.setSource(sources: Converter.encodeSourceObjects(sourceModels: sources))
    }

    func deleteFollowedSource(source: SourceModel) {
        var sources = getFollowedSources()
        sources.remove(at: sources.firstIndex(of: source) ?? 0)
        cacheService.saveChangedListSources(sources: Converter.encodeSourceObjects(sourceModels: sources))
    }
}
