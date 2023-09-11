//  Created by илья on 11.09.23.

import Foundation

protocol FeedConverterProtocol {
    func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel]
}

final class FeedConverter: FeedConverterProtocol {
    func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }
}
