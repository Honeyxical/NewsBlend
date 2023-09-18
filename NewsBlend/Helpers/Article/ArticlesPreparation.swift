//  Created by илья on 17.09.23.

import Foundation

protocol ArticlesPreparationsProtocol {
    func prepareArticles(articles: [ArticleModel]) -> [PresenterModel]
}

final class ArticlesPreparations: ArticlesPreparationsProtocol {
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        return dateFormatter
    }()

    func prepareArticles(articles: [ArticleModel]) -> [PresenterModel] {
        var result: [PresenterModel] = []
        for article in articles {
            var tempArticle = article
            let targetDate = dateFormatter.date(from: tempArticle.publishedAt ?? "") ?? Date()
            tempArticle.timeSincePublication = RelativeDateTimeFormatter().localizedString(for: targetDate, relativeTo: Date())
            result.append(article.map(articleModel: tempArticle))
        }
        return result
    }
}
