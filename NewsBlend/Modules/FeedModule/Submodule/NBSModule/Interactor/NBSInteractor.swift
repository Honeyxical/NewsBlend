//  Created by илья on 13.08.23.

import Foundation

final class NBSInteractor {
    weak var output: NBSInteractorOutputProtocol?
    private let networkService: NBSNetworkServiceProtocol
    private let cacheService: NBSStorageProtocol
    private let articleParser: ArticleParserProtocol
    private let articleCoder: ArticleCodingProtocol
    private let sourceCoder: SourceCodingProtocol

    private let defaultPageSize = 10

    init(networkService: NBSNetworkServiceProtocol,
         cacheService: NBSStorageProtocol,
         articleParser: ArticleParserProtocol,
         articleCoder: ArticleCodingProtocol,
         sourceCoder: SourceCodingProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.articleParser = articleParser
        self.articleCoder = articleCoder
        self.sourceCoder = sourceCoder
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getArticlesBySource(source: SourceModel) {
        let articlesFromCache = articleCoder.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
        output?.didReceive(articles: articlesFromCache)
    }

    func getArticlesByAllSource() {
        let sources = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        var articlesFromCache: [ArticleModel] = []
        for source in sources {
            let article = articleCoder.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
            articlesFromCache.append(contentsOf: article)
        }
        self.output?.didReceive(articles: articlesFromCache)
    }

    func loadData() {
        let sources = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        for source in sources {
            networkService.getArticlesBySource(source: source, pageSize: defaultPageSize) { [self] result in
                switch result {
                case .success(let data):
                    let parsedArticlesFromNetwork = articleParser.parseArticle(data: data)
                    if !parsedArticlesFromNetwork.isEmpty{
                        let encodedArticle = self.articleCoder.encodeArticleObjects(articles: parsedArticlesFromNetwork)
                        cacheService.setArticles(data: encodedArticle, source: source.id)
                        output?.articlesLoaded()
                    }
                    output?.articlesLoaded()
                case .failure(let error):
                    switch error {
                    case .parseFailed:
                        output?.filedParseData()
                    }
                }
            }
        }
    }

    func getSources() {
        var sourcesWithAll = [SourceModel(id: "all", name: "All", type: .all, isSelected: true)]
        var sourcesWithoutAll: [SourceModel] = []
        let sourcesFromCache = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        if sourcesFromCache.count > 1 {
            sourcesWithAll += sourcesFromCache
            output?.didReceive(sources: sourcesWithAll)
            return
        }
        sourcesWithoutAll += sourcesFromCache
        output?.didReceive(sources: sourcesWithoutAll)
    }

    func startUpdateTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: Double(getInterval()), repeats: true) { _ in
            self.loadData()
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    private func getInterval() -> Int{
        let interval = cacheService.getUpdateInterval()
        return interval == 0 ? 600 : interval
    }
}
