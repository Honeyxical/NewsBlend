//  Created by илья on 17.09.23.

import Foundation

protocol ArticleConverterProtocol {
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel]
}

final class ArticleConverter: ArticleConverterProtocol {
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }
}
