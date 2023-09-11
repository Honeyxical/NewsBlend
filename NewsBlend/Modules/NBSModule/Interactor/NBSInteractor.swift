//  Created by илья on 13.08.23.

import Foundation

final class NBSInteractor {
    weak var output: NBSInteractorOutputProtocol?
    private let networkService: NBSNetworkServiceProtocol
    private let cacheService: NBSStorageProtocol
    private let parser: NBSParserProtocol
    private let converter: NBSConverterProtocol
    private let articleCoder: ArticleCodingProtocol
    private let sourceCoder: SourceCodingProtocol
    
    private let defaultPageSize = 10

    init(networkService: NBSNetworkServiceProtocol,
         cacheService: NBSStorageProtocol,
         parser: NBSParserProtocol,
         converter: NBSConverterProtocol,
         articleCoder: ArticleCodingProtocol,
         sourceCoder: SourceCodingProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.parser = parser
        self.converter = converter
        self.articleCoder = articleCoder
        self.sourceCoder = sourceCoder
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getArticlesBySource(source: SourceModel) {
        let articlesFromCache = articleCoder.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
        networkService.getArticlesBySource(source: source, pageSize: 10) { result in
            guard let data = try? result.get() else {
                self.output?.didReceive(articles: articlesFromCache)
                return
            }
            let articlesFromNetwork = self.parser.parseArticle(data: data)
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArtcles(data: self.articleCoder.encodeArticleObjects(articles: articlesFromNetwork), source: "all")
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getArticlesByAllSource() {
        let sources = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        let articlesFromCache = articleCoder.decodeArticleObjects(data: cacheService.getArticles(source: "all"))
        let group = DispatchGroup()
        group.enter()
        for source in sources {
            networkService.getArticlesBySource(source: source, pageSize: 3) { result in
                guard let data = try? result.get() else {
                    self.output?.didReceive(articles: articlesFromCache)
                    return
                }
                let articlesFromNetwork = self.parser.parseArticle(data: data)
                if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                    self.cacheService.setArtcles(data: self.articleCoder.encodeArticleObjects(articles: articlesFromNetwork), source: "all")
                    self.output?.didReceive(articles: articlesFromNetwork)
                } else {
                    self.output?.didReceive(articles: articlesFromCache)
                }
            }
        }
    }

    func getSources() {
        var sourcesFromCache = [SourceModel(id: "all", name: "All", category: "", language: "", country: "", isSelected: true)]
//        var sourcesFromCache: [SourceModel] = []
        sourcesFromCache += sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }
}
