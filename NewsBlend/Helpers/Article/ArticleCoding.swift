//  Created by илья on 11.09.23.

import Foundation

protocol ArticleCodingProtocol {
    func encodeArticleObjects(articles: [ArticleModel]) -> Data
    func decodeArticleObjects(data: Data) -> [ArticleModel]
}

final class ArticleCoding: ArticleCodingProtocol {
    func encodeArticleObjects(articles: [ArticleModel]) -> Data {
        guard let articles = try? JSONEncoder().encode(articles) else {
            return Data()
        }
        return articles
    }

    func decodeArticleObjects(data: Data) -> [ArticleModel] {
        guard let articles = try? JSONDecoder().decode([ArticleModel].self, from: data) else {
            return []
        }
        return articles
    }
}
