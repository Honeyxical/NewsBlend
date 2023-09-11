//  Created by илья on 11.09.23.

import Foundation

protocol NBSConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel]
    func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel]
}

final class NBSConverter: NBSConverterProtocol {
    func transferSourceObject(sources: [Sources]) -> [SourceModel] {
        var sourceModels: [SourceModel] = []
        for source in sources {
            sourceModels.append(source.map(source: source))
        }
        return sourceModels
    }
    
    func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }
}