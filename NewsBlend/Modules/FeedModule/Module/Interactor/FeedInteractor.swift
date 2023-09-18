//  Created by илья on 01.08.23.

import Foundation

final class FeedInteractor {
    weak var output: FeedInteractorOutputProtocol?
    private let networkService: FeedNetworkServiceProtocol
    private let cacheService: FeedStorageProtocol
    private let articleParser: ArticleParser
    private let articleCoder: ArticleCodingProtocol
    private let sourceCoder: SourceCodingProtocol
    
    private let initialSource: SourceModel
    private let defaultSourceHotNews: SourceModel
    private let articlesEstimate = 5
    
    init(networkService: FeedNetworkServiceProtocol,
         cacheService: FeedStorageProtocol,
         articleParser: ArticleParser,
         articleCoder: ArticleCodingProtocol,
         sourceCoder: SourceCodingProtocol,
         initialSource: SourceModel,
         defaultSourceHotNews: SourceModel) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.articleParser = articleParser
        self.articleCoder = articleCoder
        self.sourceCoder = sourceCoder
        self.initialSource = initialSource
        self.defaultSourceHotNews = defaultSourceHotNews
    }
}

extension FeedInteractor: FeedInteractorInputProtocol {
    func loadData() {
        var articlesFromCache = articleCoder.decodeArticleObjects(data: cacheService.getArticles())
        articlesFromCache.sort { $0.publishedAt ?? "" < $1.publishedAt ?? "" }
        networkService.getArticles(source: defaultSourceHotNews, articlesCount: articlesEstimate) { [self] result in
            switch result {
            case .success(let data):
                let articlesFromNetwork = articleParser.parseArticle(data: data)
                if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                    setArticlesIntoCache(articles: articlesFromNetwork)
                    output?.didReceive(articles: articlesFromNetwork)
                } else {
                    output?.didReceive(articles: articlesFromCache)
                }
            case .failure(let error):
                switch error {
                case .noInternet:
                    errorHandling(articlesFromCache: articlesFromCache)
                case .parseFailed:
                    errorHandling(articlesFromCache: articlesFromCache)
                }
            }
        }
    }

    func isFirstStart() {
        if !cacheService.getInitValue() {
            cacheService.setInitValue(initValue: true)
            setSource(sources: [initialSource])
        }
    }

    func setSource(sources: [SourceModel]) {
        cacheService.setSource(data: sourceCoder.encodeSourceObjects(sourceModels: sources)) // Да, так надо. Чтобы его убрать нужно делать новый модуль с экраном загрузки
    }

    func getUpdateInterval() -> Int {
        let interval = cacheService.getUpdateInterval()
        return interval == 0 ? 600 : interval
    }
    
    func startUpdateTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: Double(getUpdateInterval()), repeats: true) { _ in
            self.loadData()
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func setArticlesIntoCache(articles: [ArticleModel]) {
        cacheService.setArticles(data: articleCoder.encodeArticleObjects(articles: articles))
    }

    private func errorHandling(articlesFromCache: [ArticleModel]) {
        if !articlesFromCache.isEmpty {
            self.output?.didReceive(articles: articlesFromCache)
        } else {
            self.output?.didReceiveFail()
        }
    }
}
