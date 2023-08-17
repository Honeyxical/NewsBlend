//  Created by илья on 01.08.23.

import Foundation

final class FeedInteractor {
    weak var output: FeedInteractorOutputProtocol?
    let feedNetworkService: FeedNetworkServiceProtocol
    let feedDataService: FeedCoreDataServiceProtocol
    private let initialSource = SourceModel(id: "abc-news", name: "ABC News", category: "", language: "", country: "", isSelected: true)
    private let defaultUpdateInterval = 4
    
    init(feedNetworkService: FeedNetworkServiceProtocol, feedDataService: FeedCoreDataServiceProtocol) {
        self.feedNetworkService = feedNetworkService
        self.feedDataService = feedDataService
    }
}

extension FeedInteractor: FeedInteractorInputProtocol {
    func loadData() {
        var articles: [ArticleModel] = []
        var hotArticles: [ArticleModel] = []

        feedNetworkService.getHotNews(country: "us") { data in
            guard let hotNews = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            hotArticles = Converter.transferDTOtoModel(articlesArray: hotNews.articles)
            hotArticles = Converter.setDate(articles: hotArticles)
            self.output?.didReceive(articles: articles, hotArticles: hotArticles)
        }

        feedNetworkService.getNews { data in
            guard let news = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            articles = Converter.transferDTOtoModel(articlesArray: news.articles)
            articles = Converter.setDate(articles: articles)
            self.output?.didReceive(articles: articles, hotArticles: hotArticles)
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
}
