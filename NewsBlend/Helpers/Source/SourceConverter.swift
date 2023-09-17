//  Created by илья on 17.09.23.

import Foundation

protocol SourceConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel]
}

final class SourceConverter: SourceConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }
}
