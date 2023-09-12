//  Created by илья on 11.09.23.

import Foundation

protocol NBSParserProtocol {
    func parseArticle(data: Data) -> [ArticleModel]
}

final class NBSParser: NBSParserProtocol {
    private let articleConverter: NBSArticleConverterProtocol

    init(articleConverter: NBSArticleConverterProtocol) {
        self.articleConverter = articleConverter
    }

    func parseArticle(data: Data) -> [ArticleModel] {
        guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return [] }
        return articleConverter.transferDTOToModel(articlesArray: articlesDTO.articles)
    }
}
