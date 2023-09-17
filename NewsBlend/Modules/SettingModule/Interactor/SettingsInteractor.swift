//  Created by илья on 01.08.23.

import Foundation

final class SettingsInteractor {
    weak var output: SettingsInteractorOutputProtocol?
    private let cacheService: SettingStorageProtocol
    private let networkService: SettingNetworkServiceProtocol
    private let sourceParser: SourceParserProtocol
    private let sourceCoder: SourceCodingProtocol
    private let defaultLanguage = "en"

    init(cacheService: SettingStorageProtocol,
         networkService: SettingNetworkServiceProtocol,
         sourceParser: SourceParserProtocol,
         sourceCoder: SourceCodingProtocol) {
        self.cacheService = cacheService
        self.networkService = networkService
        self.sourceParser = sourceParser
        self.sourceCoder = sourceCoder
    }
}

extension SettingsInteractor: SettingsInteractorInputProtocol {
    func getAllSources() {
        let sourcesFromCache = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        networkService.getSources(sourceLanguage: defaultLanguage) { result in
            switch result {
            case .success(let data):
                let sourcesFromNetwork = self.sourceParser.parseSource(data: data)
                if !sourcesFromNetwork.isEmpty {
                    self.output?.didReceive(sources: self.combiningSourceResults(storage: sourcesFromCache,
                                                                                 network: sourcesFromNetwork))
                }
            case .failure(let error):
                switch error {
                case .errorConfigureUrl:
                    self.output?.didReceive(sources: self.getFollowedSources())
                case .errorParsingData:
                    self.output?.didReceive(sources: self.getFollowedSources())
                case .noInternet:
                    self.output?.didReceive(sources: self.getFollowedSources())
                }
            }
        }
    }

    func getIntervals() {
        output?.didReceive(interval: cacheService.getUpdateInterval())
    }

    func getFollowedSources() -> [SourceModel] {
        let unarchive = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        return unarchive
    }

    func setInterval(interval: UpdateIntervals) {
        cacheService.setUpdateInterval(interval: interval)
    }

    func setFollowedSource(source: SourceModel) {
        var sources = getFollowedSources()
        sources.append(source)
        cacheService.setSource(sources: sourceCoder.encodeSourceObjects(sourceModels: sources))
    }

    func deleteFollowedSource(source: SourceModel) {
        var sources = getFollowedSources()
        if sources.count > 1{
            sources.remove(at: sources.firstIndex(of: source) ?? 0)
            cacheService.saveChangedListSources(sources: sourceCoder.encodeSourceObjects(sourceModels: sources))
            return
        }
        output?.failDeletingSource()
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

    private func deleteSourceArticles(source: SourceModel) {
        cacheService.deleteSourceArticles(sourceId: source.id)
    }
}
