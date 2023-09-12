//  Created by илья on 11.09.23.

import Foundation

protocol SettingConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel]
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel]
}

final class SettingConverter: SettingConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }
    
    func transferDTOToModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }
}
