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
            let sources = self.transferObject(sources: engSources.sources)
            self.output?.didReceive(sources: self.combiningResults(storage: self.getFollowedSources(), network: sources))
        }
    }

    func getIntervals() {
        output?.didReceive(interval: dataService.getUpdateInterval())
    }

    func getFollowedSources() -> [SourceModel] {
        let unarchive = decodeObjects(data: dataService.getSources())
        return unarchive
    }

    func setInterval(interval: Int) {
        dataService.setUpdateUnterval(interval: interval)
    }

    func setFollowedSource(source: SourceModel) {
        source.isSelected = source.isSelected == false ? true : false
        var sources = getFollowedSources()
        sources.append(source)
        dataService.setSource(sources: encodeObjects(sourceModels: sources))
    }

    func deleteFollowedSource(source: SourceModel) {
        var sources = getFollowedSources()
        sources.remove(at: sources.firstIndex(of: source) ?? 0)
        dataService.saveChangedListSources(sources: encodeObjects(sourceModels: sources))
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

    private func decodeObjects(data: Data) -> [SourceModel] {
        guard let source = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SourceModel] else { return []}
        return source
    }

    private func encodeObjects(sourceModels: [SourceModel]) -> Data {
        let models = try? NSKeyedArchiver.archivedData(withRootObject: sourceModels, requiringSecureCoding: false)
        guard let models: Data = models else {
            return Data()
        }
        return models
    }

    private func combiningResults(storage: [SourceModel], network: [SourceModel]) -> [SourceModel] {
        if storage.count < 1 {
            return network
        }
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
