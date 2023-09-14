//  Created by илья on 11.09.23.

import Foundation

protocol FeedArticleConverterProtocol {
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel]
}

final class FeedArticleConverter: FeedArticleConverterProtocol {
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }
}
