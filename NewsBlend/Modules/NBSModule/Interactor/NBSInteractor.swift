//  Created by илья on 13.08.23.

import Foundation

final class NBSInteractor {
    weak var output: NBSInteractorOutputProtocol?
    private let networkService: NBSNetworkServiceProtocol
    private let cacheService: NBSStorageProtocol
    private let parser: ParserProtocol
    private let articleConverter: ArticleConverterProtocol
    private let sourceConverter: SourceConverterProtocol
    
    private let defaultPageSize = 10

    init(networkService: NBSNetworkServiceProtocol,
         cacheService: NBSStorageProtocol,
         parser: ParserProtocol,
         articleConverter: ArticleConverterProtocol,
         sourceConverter: SourceConverterProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.parser = parser
        self.articleConverter = articleConverter
        self.sourceConverter = sourceConverter
        
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getArticlesBySource(source: SourceModel) {
        let articlesFromCache = articleConverter.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
        parser.parseNBSArticlesBySource(source: source, pageSize: defaultPageSize, network: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArtcles(data: self.articleConverter.encodeArticleObjects(articles: articlesFromNetwork), source: source.id)
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getArticlesByAllSource() {
        let sources = sourceConverter.decodeSourceObjects(data: cacheService.getSources())
        let articlesFromCache = articleConverter.decodeArticleObjects(data: cacheService.getArticles(source: "all"))
        parser.parseArticlesByAllSource(sources: sources, pageSize: defaultPageSize, networkService: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArtcles(data: self.articleConverter.encodeArticleObjects(articles: articlesFromNetwork), source: "all")
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getSources() {
        var sourcesFromCache = [SourceModel(id: "all", name: "All", category: "", language: "", country: "", isSelected: true)]
//        var sourcesFromCache: [SourceModel] = []
        sourcesFromCache += sourceConverter.decodeSourceObjects(data: cacheService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }
}
