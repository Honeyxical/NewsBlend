//  Created by илья on 11.09.23.

import Foundation

protocol SettingParserProtocol {
    func parseFeedSource(data: Data) -> [ArticleModel]
    func parseSource(data: Data) -> [SourceModel]
}

final class SettingParser: SettingParserProtocol {
    private let converter: SettingConverterProtocol

    init(converter: SettingConverterProtocol) {
        self.converter = converter
    }

    func parseFeedSource(data: Data) -> [ArticleModel] {
        guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return []}
        let articles = converter.transferDTOToModel(articlesArray: articlesDTO.articles)
        return articles.sorted { $0.publishedAt ?? "" > $1.publishedAt ?? "" }
    }

    func parseSource(data: Data) -> [SourceModel] {
        guard let sourcesDTO = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else { return []}
        return converter.transferSourceObject(sources: sourcesDTO.sources)
    }
}
