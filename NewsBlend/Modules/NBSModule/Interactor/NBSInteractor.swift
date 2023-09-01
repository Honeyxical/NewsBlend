//  Created by илья on 13.08.23.

import Foundation

class NBSInteractor {
    var output: NBSInteractorOutputProtocol?
    let networkService: NBSNetworkServiceProtocol
    let cacheService: NBSStorageProtocol
    let parser = Parser()
    private let defaultPageSize = 10

    init(networkService: NBSNetworkServiceProtocol, cacheService: NBSStorageProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getArticlesBySource(source: SourceModel) {
        let articlesFromCache = Converter.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
        parser.parseNBSArticlesBySource(source: source, pageSize: defaultPageSize, network: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArtcles(data: Converter.encodeArticleObjects(articles: articlesFromNetwork), source: source.id)
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getArticlesByAllSource() {
        let sources = Converter.decodeSourceObjects(data: cacheService.getSources())
        let articlesFromCache = Converter.decodeArticleObjects(data: cacheService.getArticles(source: "all"))
        parser.parseArticlesByAllSource(sources: sources, pageSize: defaultPageSize, networkService: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArtcles(data: Converter.encodeArticleObjects(articles: articlesFromNetwork), source: "all")
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getSources() {
//        var sourcesFromCache = [SourceModel(id: "all", name: "All", category: "", language: "", country: "", isSelected: true)]
        var sourcesFromCache: [SourceModel] = []
        sourcesFromCache += Converter.decodeSourceObjects(data: cacheService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }
}
