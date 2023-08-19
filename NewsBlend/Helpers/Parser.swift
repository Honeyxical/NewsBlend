//  Created by Ilya Benikov on 19.08.23.

import Foundation

class Parser {
    static func parseAllSource(sources: [SourceModel], networkService: NBSNetworkServiceProtocol, completition: @escaping ([ArticleModel]) -> Void) {
        let group = DispatchGroup()
        var articles: [ArticleModel] = []
        
        for source in sources {
            group.enter()
            networkService.getArticlesBySource(source: source) { data in
                guard let articlesParsed = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else {
                    return
                }
                articles += Converter.setDate(articles: Converter.transferDTOtoModel(articlesArray: articlesParsed.articles))
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completition(articles)
        }
    }
}
