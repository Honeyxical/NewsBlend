//  Created by илья on 13.08.23.

import Foundation

final class NBSInteractor {
    weak var output: NBSInteractorOutputProtocol?
    private let networkService: NBSNetworkServiceProtocol
    private let cacheService: NBSStorageProtocol
    private let parser: NBSParserProtocol
    private let articleConverter: NBSArticleConverterProtocol
    private let articleCoder: ArticleCodingProtocol
    private let sourceCoder: SourceCodingProtocol
    private let sourceConverter: NBSSourceConverterProtocol
    
    private let defaultPageSize = 10

    init(networkService: NBSNetworkServiceProtocol,
         cacheService: NBSStorageProtocol,
         parser: NBSParserProtocol,
         articleConverter: NBSArticleConverterProtocol,
         articleCoder: ArticleCodingProtocol,
         sourceCoder: SourceCodingProtocol,
         sourceConverter: NBSSourceConverterProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.parser = parser
        self.articleConverter = articleConverter
        self.articleCoder = articleCoder
        self.sourceCoder = sourceCoder
        self.sourceConverter = sourceConverter
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
                self.cacheService.setArticles(data: self.articleCoder.encodeArticleObjects(articles: articlesFromNetwork), source: source.id)
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
        var articlesFromNetwork: [ArticleModel] = []

        for source in sources {
            group.enter()
            networkService.getArticlesBySource(source: source, pageSize: defaultPageSize) { result in
                switch result {
                case .success:
                    guard let data = try? result.get() else { return }
                    articlesFromNetwork.append(contentsOf: self.parser.parseArticle(data: data))
                    group.leave()
                case .failure:
                    articlesFromNetwork = articlesFromCache
                    group.leave()
                }
            }
        }
        
        group.notify(queue: .main) {
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheService.setArticles(data: self.articleCoder.encodeArticleObjects(articles: articlesFromNetwork), source: "all")
                self.output?.didReceive(articles: articlesFromNetwork)
                return
            }
            self.output?.didReceive(articles: articlesFromCache)
        }
        
    }

    func getSources() {
        var sourcesFromCache = [SourceModel(id: "all", name: "All", category: "", language: "", country: "", isSelected: true)]
        sourcesFromCache += sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }
}
