//  Created by Ilya Benikov on 10.09.23.

import Foundation

protocol ArticleConverterProtocol {
    func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel]
    func encodeArticleObjects(articles: [ArticleModel]) -> Data
    func decodeArticleObjects(data: Data) -> [ArticleModel]
    func setDate(articles: [ArticleModel]) -> [ArticleModel]
}

final class ArticleConverter: ArticleConverterProtocol {
    func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        articleModels = setDate(articles: articleModels)
        return articleModels
    }

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
    
    func setDate(articles: [ArticleModel]) -> [ArticleModel]{
        if articles.isEmpty {
            return articles
        }
        var articles = articles
        for counter in 0...articles.count - 1 {
            articles[counter].timeSincePublication = getDifferenceFromNowAndDate(dateString: articles[counter].publishedAt)
        }
        return articles
    }
    
    private func getDifferenceFromNowAndDate(dateString: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        let targetDate = dateFormatter.date(from: dateString) ?? Date()
        return RelativeDateTimeFormatter().localizedString(for: targetDate, relativeTo: Date())
    }
}
