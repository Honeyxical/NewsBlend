//  Created by илья on 11.09.23.

import Foundation

protocol SettingSourceConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel]
}

final class SettingSourceConverter: SettingSourceConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }
}
