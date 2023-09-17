//  Created by илья on 17.09.23.

import Foundation

protocol SourceParserProtocol {
    func parseSource(data: Data) -> [SourceModel]
}

final class SourceParser: SourceParserProtocol {
    private let sourceConverter: SourceConverterProtocol

    init(sourceConverter: SourceConverterProtocol) {
        self.sourceConverter = sourceConverter
    }

    func parseSource(data: Data) -> [SourceModel] {
        guard let sourcesDTO = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else { return []}
        return sourceConverter.transferSourceObject(sources: sourcesDTO.sources)
    }
}
