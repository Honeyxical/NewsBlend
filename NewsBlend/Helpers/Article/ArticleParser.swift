//  Created by илья on 17.09.23.

import Foundation

protocol ArticleParserProtocol {
    func parseArticle(data: Data) -> [ArticleModel]
}

final class ArticleParser: ArticleParserProtocol {
    private let articleConverter: ArticleConverterProtocol

    init(articleConverter: ArticleConverterProtocol) {
        self.articleConverter = articleConverter
    }

    func parseArticle(data: Data) -> [ArticleModel] {
        guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return [] }
        return articleConverter.transferDTOToModel(articlesArray: articlesDTO.articles)
    }
}
