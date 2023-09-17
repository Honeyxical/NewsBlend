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
        let articlesFromCache = articleCoder.decodeArticleObjects(data: cacheService.getArticles())
        networkService.getArticles(source: defaultSourceHotNews, articlesCount: articlesEstimate) { result in
            switch result {
            case .success(let data):
                let articlesFromNetwork = self.articleParser.parseArticle(data: data)
                if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                    self.setArticlesIntoCache(articles: articlesFromNetwork)
                    self.output?.didReceive(articles: articlesFromNetwork)
                } else {
                    self.output?.didReceive(articles: articlesFromCache)
                }
            case .failure(let error):
                switch error {
                case .errorUrlConfiguring:
                    // я не придумал как обработать
                    break
                case .noInternet:
                    if !articlesFromCache.isEmpty {
                        self.output?.didReceive(articles: articlesFromCache)
                    } else {
                        self.output?.didReceiveFail()
                    }
                case .parseFailed:
                    if !articlesFromCache.isEmpty {
                        self.output?.didReceive(articles: articlesFromCache)
                    } else {
                        self.output?.didReceiveFail()
                    }
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
}
