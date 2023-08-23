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
    let feedNetworkService: FeedNetworkServiceProtocol
    let feedDataService: FeedCoreDataServiceProtocol
    private let initialSource: SourceModel
    private let defaultUpdateInterval = 4
    
    init(feedNetworkService: FeedNetworkServiceProtocol, feedDataService: FeedCoreDataServiceProtocol, initialSource: SourceModel) {
        self.feedNetworkService = feedNetworkService
        self.feedDataService = feedDataService
        self.initialSource = initialSource
    }
}

extension FeedInteractor: FeedInteractorInputProtocol {
    func loadData() {
        let articlesFromCache = Converter.decodeArticleObjects(data: feedDataService.getArticles())
        Parser.parseFeedSource(network: feedNetworkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.cacheArticles(articles: articlesFromNetwork)
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func isFirstStart() {
        if feedDataService.getInitValue() == false {
            feedDataService.setInitValue(initValue: true)
            setSource(sources: [initialSource])
            setUpdateInterval(interval: defaultUpdateInterval)
        }
    }

    func setSource(sources: [SourceModel]) {
        feedDataService.setSource(data: Converter.encodeSourceObjects(sourceModels: sources))
    }

    func setUpdateInterval(interval: Int) {
        feedDataService.setInterval(interval: defaultUpdateInterval)
    }

    func getUpdateInterval() -> Int {
        UpdateInterval(rawValue: feedDataService.getInterval())?.rawValue ?? UpdateInterval.tenMinutes.rawValue
    }
    
    func startUpdateDemon() {
        let timer = Timer.scheduledTimer(withTimeInterval: Double(getUpdateInterval()), repeats: true) { _ in
            self.loadData()
        }
        RunLoop.current.add(timer, forMode: .common)
    }
    
    private func cacheArticles(articles: [ArticleModel]) {
        feedDataService.setArticles(data: Converter.encodeArticleObjects(articles: articles))
    }
}
