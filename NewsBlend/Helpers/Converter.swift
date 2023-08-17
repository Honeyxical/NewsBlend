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
        guard let source = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SourceModel] else {
            return []
        }
        return source
    }

    static func encodeSourceObjects(sourceModels: [SourceModel]) -> Data {
        guard let models = try? NSKeyedArchiver.archivedData(withRootObject: sourceModels, requiringSecureCoding: false) else {
            return Data()
        }
        return models
    }

    static func combiningSourceResults(storage: [SourceModel], network: [SourceModel]) -> [SourceModel] {
        if storage.count < 1 {
            return network
        }
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
        for counter in 0...articles.count - 1 {
            articles[counter].timeSincePublication = Date().getDifferenceFromNowAndDate( articles[counter].publishedAt) ?? ""
        }
        return articles
    }

    // MARK: Articles methods

    static func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }

    static func encodeArticleObjects(articles: [ArticleModel]) -> Data {
        guard let articles = try? NSKeyedArchiver.archivedData(withRootObject: articles, requiringSecureCoding: false) else {
            return Data()
        }
        return articles
    }

    static func decodeArticleObjects(data: Data) -> [ArticleModel] {
        guard let articles = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [ArticleModel] else {
            return []
        }
        return articles
    }
}
