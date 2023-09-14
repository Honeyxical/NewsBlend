//  Created by илья on 11.09.23.

import Foundation

protocol FeedParserProtocol {
    func parseArticle(data: Data) -> [ArticleModel]
}

final class FeedParser: FeedParserProtocol {
    private let converter: FeedArticleConverterProtocol

    init(converter: FeedArticleConverterProtocol) {
        self.converter = converter
    }

    func parseArticle(data: Data) -> [ArticleModel] {
        guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return [] }
        return converter.transferDTOToModel(articlesArray: articlesDTO.articles)
    }
}
