//  Created by илья on 12.09.23.

import Foundation

protocol SettingArticleConverterProtocol {
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel]
}

final class SettingArticleConverter: SettingArticleConverterProtocol {
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }
}
