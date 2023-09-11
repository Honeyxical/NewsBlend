//  Created by илья on 11.09.23.

import Foundation

protocol SourceCodingProtocol {
    func decodeSourceObjects(data: Data) -> [SourceModel]
    func encodeSourceObjects(sourceModels: [SourceModel]) -> Data
}

final class SourceCoding: SourceCodingProtocol {
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
