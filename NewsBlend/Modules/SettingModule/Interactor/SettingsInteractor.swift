//  Created by илья on 01.08.23.

import Foundation

final class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    private let cacheService: SettingStorageProtocol
    private let networkService: SettingNetworkServiceProtocol
    private let parser: ParserProtocol
    private let defaultLanguage = "en"
    private let converter: SourceConverterProtocol

    init(cacheService: SettingStorageProtocol, networkService: SettingNetworkServiceProtocol, parser: ParserProtocol, converter: SourceConverterProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.parser = parser
        self.converter = converter
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
    func getAllSources() {
        let sourcesFromCahce = converter.decodeSourceObjects(data: cacheService.getSources())
        parser.parseSource(defaultLanguage: defaultLanguage, network: networkService) { sourcesFromNetwork in
            if sourcesFromNetwork.isEmpty {
                self.output?.didReceive(sources: sourcesFromCahce)
            } else {
                self.output?.didReceive(sources: self.combiningSourceResults(storage: sourcesFromCahce,
                                                                                  network: sourcesFromNetwork))
            }
        }
    }

    func getIntervals() {
        output?.didReceive(interval: cacheService.getUpdateInterval())
    }

    func getFollowedSources() -> [SourceModel] {
        let unarchive = converter.decodeSourceObjects(data: cacheService.getSources())
        return unarchive
    }

    func setInterval(interval: UpdateIntervals) {
        cacheService.setUpdateUnterval(interval: interval)
    }

    func setFollowedSource(source: SourceModel) {
        var source = source
        source.isSelected.toggle()
        var sources = getFollowedSources()
        sources.append(source)
        cacheService.setSource(sources: converter.encodeSourceObjects(sourceModels: sources))
    }

    func deleteFollowedSource(source: SourceModel) {
        var sources = getFollowedSources()
        sources.remove(at: sources.firstIndex(of: source) ?? 0)
        cacheService.saveChangedListSources(sources: converter.encodeSourceObjects(sourceModels: sources))
    }
    
    private func combiningSourceResults(storage: [SourceModel], network: [SourceModel]) -> [SourceModel] {
        if storage.count < 1 {
            return network
        }
        var network = network
        
        for counterS in 0...storage.count - 1 {
            for counterN in 0...network.count - 1{
                if network[counterN].name == storage[counterS].name && network[counterN].isSelected != storage[counterS].isSelected {
                    network[counterN].isSelected = storage[counterS].isSelected
                }
            }
        }
        return network
    }
}
