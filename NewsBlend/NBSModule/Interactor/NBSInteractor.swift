//  Created by илья on 13.08.23.

import Foundation

class NBSInteractor {
    var output: NBSInteractorOutputProtocol?
    let networkService: NBSNetworkServiceProtocol
    let cacheService: NBSDataServiceProtocol

    init(networkService: NBSNetworkServiceProtocol, cacheService: NBSDataServiceProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getArticlesBySource(source: SourceModel) {
        let articlesFromCache = Converter.decodeArticleObjects(data: cacheService.getArticles())
        Parser.parseNBSArticlesBySource(source: source, network: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArtcles(data: Converter.encodeArticleObjects(articles: articlesFromNetwork))
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getArticlesByAllSource() {
        let sources = Converter.decodeSourceObjects(data: cacheService.getSources())
        let articlesFromCache = Converter.decodeArticleObjects(data: cacheService.getArticlesByAllSource())
        Parser.parseArticlesByAllSource(sources: sources, networkService: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArticlesByAllSource(data: Converter.encodeArticleObjects(articles: articlesFromNetwork))
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getSources() {
        var sourcesFromCache = [SourceModel(id: "", name: "All", category: "", language: "", country: "", isSelected: true)]
        sourcesFromCache += Converter.decodeSourceObjects(data: cacheService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }
}
