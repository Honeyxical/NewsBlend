//  Created by илья on 17.08.23.

import Foundation

class Converter {

    // MARK: Sources methods

    static func transferSourceObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }

    static func decodeSourceObjects(data: Data) -> [SourceModel] {
        guard let source = try? JSONDecoder().decode([SourceModel].self, from: data) else {
            return []
        }
        return source
    }

    static func encodeSourceObjects(sourceModels: [SourceModel]) -> Data {
        guard let models = try? JSONEncoder().encode(sourceModels) else {
            return Data()
        }
        return models
    }

    static func combiningSourceResults(storage: [SourceModel], network: [SourceModel]) -> [SourceModel] {
        if storage.count < 1 {
            return network
        }
        var network = network

        for counterS in 0...storage.count - 1 {
            for counterN in 0...network.count - 1{
                if network[counterN].name == storage[counterS].name && network[counterN].isSelected != storage[counterS].isSelected {
                    network[counterN].isSelected = storage[counterS].isSelected
                }
            }
        }
        return network
    }

    // MARK: Date methods

    static func setDate(articles: [ArticleModel]) -> [ArticleModel]{
        if articles.isEmpty {
            return articles
        }
        var articles = articles
        for counter in 0...articles.count - 1 {
            articles[counter].timeSincePublication = Converter.getDifferenceFromNowAndDate(dateString: articles[counter].publishedAt) ?? ""
        }
        return articles
    }

    // MARK: Articles methods

    static func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        articleModels = setDate(articles: articleModels)
        return articleModels
    }

    static func encodeArticleObjects(articles: [ArticleModel]) -> Data {
        guard let articles = try? JSONEncoder().encode(articles) else {
            return Data()
        }
        return articles
    }

    static func decodeArticleObjects(data: Data) -> [ArticleModel] {
        guard let articles = try? JSONDecoder().decode([ArticleModel].self, from: data) else {
            return []
        }
        return articles
    }

    private static func getDifferenceFromNowAndDate(dateString: String) -> String? {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

        if let targetDate = dateFormatter.date(from: dateString) {
            let currentDate = Date()
            let calendar = Calendar.current

            let components = calendar.dateComponents([.day, .hour, .minute], from: targetDate, to: currentDate)

            if let days = components.day, days > 0 {
                return "\(days) days ago"
            } else if let hours = components.hour, hours > 0 {
                return "\(hours) hours ago"
            } else if let minutes = components.minute, minutes > 0 {
                return "\(minutes) minutes ago"
            } else {
                return "now"
            }
        }
        return nil
    }
}
