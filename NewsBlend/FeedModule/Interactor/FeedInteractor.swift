//  Created by илья on 01.08.23.

import Foundation

enum UpdateInterval: Int {
    case oneMinute = 60
    case threeMinutes = 180
    case fiveMinutes = 300
    case tenMinutes = 600
    case fifteenMinutes = 900
}

final class FeedInteractor {
    weak var output: FeedInteractorOutputProtocol?
    let networkService: FeedNetworkServiceProtocol
    let cacheService: FeedCoreDataServiceProtocol
    private let initialSource: SourceModel
    private let defaultUpdateInterval = 4
    
    init(networkService: FeedNetworkServiceProtocol, cacheService: FeedCoreDataServiceProtocol, initialSource: SourceModel) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.initialSource = initialSource
    }
}

extension FeedInteractor: FeedInteractorInputProtocol {
    func loadData() {
        let articlesFromCache = Converter.decodeArticleObjects(data: cacheService.getArticles())
        Parser.parseFeedSource(network: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.setArticlesIntoCache(articles: articlesFromNetwork)
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func isFirstStart() {
        if cacheService.getInitValue() == false {
            cacheService.setInitValue(initValue: true)
            setSource(sources: [initialSource])
            setUpdateInterval(interval: defaultUpdateInterval)
        }
    }

    func setSource(sources: [SourceModel]) {
        cacheService.setSource(data: Converter.encodeSourceObjects(sourceModels: sources))
    }

    func setUpdateInterval(interval: Int) {
        cacheService.setInterval(interval: defaultUpdateInterval)
    }

    func getUpdateInterval() -> Int {
        UpdateInterval(rawValue: cacheService.getInterval())?.rawValue ?? UpdateInterval.tenMinutes.rawValue
    }
    
    func startUpdateDemon() {
        let timer = Timer.scheduledTimer(withTimeInterval: Double(getUpdateInterval()), repeats: true) { _ in
            self.loadData()
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func setArticlesIntoCache(articles: [ArticleModel]) {
        cacheService.setArticles(data: Converter.encodeArticleObjects(articles: articles))
    }
}
