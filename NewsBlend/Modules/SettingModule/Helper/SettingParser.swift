//  Created by илья on 11.09.23.

import Foundation

protocol SettingParserProtocol {
    func parseFeedSource(data: Data) -> [ArticleModel]
    func parseSource(data: Data) -> [SourceModel]
}

final class SettingParser: SettingParserProtocol {
    private let articleConverter: SettingArticleConverterProtocol
    private let sourceConverter: SettingSourceConverterProtocol

    init(articleConverter: SettingArticleConverterProtocol, sourceConverter: SettingSourceConverterProtocol) {
        self.articleConverter = articleConverter
        self.sourceConverter = sourceConverter
    }

    func parseFeedSource(data: Data) -> [ArticleModel] {
        guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return []}
        let articles = articleConverter.transferDTOToModel(articlesArray: articlesDTO.articles)
        return articles
    }

    func parseSource(data: Data) -> [SourceModel] {
        guard let sourcesDTO = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else { return []}
        return sourceConverter.transferSourceObject(sources: sourcesDTO.sources)
    }
}
