//  Created by илья on 13.08.23.

import Foundation

class NBSInteractor {
    var output: NBSInteractorOutputProtocol?
    let networkService: NBSNetworkServiceProtocol
    let storageService: NBSDataServiceProtocol

    init(networkService: NBSNetworkServiceProtocol, storageService: NBSDataServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getSources() {
        output?.didReceive(sources: decodeObjects(data: storageService.getSources()))
    }

    func getArticles() {

    }
}

extension NBSInteractor {
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
}
