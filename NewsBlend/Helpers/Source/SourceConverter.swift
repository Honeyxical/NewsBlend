//  Created by илья on 17.08.23.

import Foundation

protocol SourceConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel]
    func decodeSourceObjects(data: Data) -> [SourceModel]
    func encodeSourceObjects(sourceModels: [SourceModel]) -> Data
}

final class SourceConverter: SourceConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }
    
    func decodeSourceObjects(data: Data) -> [SourceModel] {
        guard let source = try? JSONDecoder().decode([SourceModel].self, from: data) else {
            return []
        }
        return source
    }
    
    func encodeSourceObjects(sourceModels: [SourceModel]) -> Data {
        guard let models = try? JSONEncoder().encode(sourceModels) else {
            return Data()
        }
        return models
    }
}
