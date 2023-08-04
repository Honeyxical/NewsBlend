//  Created by илья on 01.08.23.

import Foundation

final class FeedInteractor {
    weak var output: FeedInteractorOutputProtocol?
    let feedNetworkService: FeedNetworkServiceProtocol
    let feedDataService: FeedCoreDataServiceProtocol
    
    init(feedNetworkService: FeedNetworkServiceProtocol, feedDataService: FeedCoreDataServiceProtocol) {
        self.feedNetworkService = feedNetworkService
        self.feedDataService = feedDataService
    }
}

extension FeedInteractor: FeedInteractorInputProtocol {
    func loadData() {
        var articles: [Article] = []
        var hotArticles: [Article] = []

        feedNetworkService.getHotNews(country: "us") { data in
            guard let hotNews = try? JSONDecoder().decode(NewsModel.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            hotArticles = self.setDate(articles: hotNews.articles)
            self.output?.didReceive(articles: articles, hotArticles: hotArticles)
        }

        feedNetworkService.getNews { data in
            guard let news = try? JSONDecoder().decode(NewsModel.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            articles = self.setDate(articles: news.articles)
            self.output?.didReceive(articles: articles, hotArticles: hotArticles)
        }
    }
    
    private func setDate(articles: [Article]) -> [Article]{
        var articles = articles
        for counter in 0...articles.count - 1 {
            articles[counter].publishedAt = Date().getDifferenceFromNowAndDate( articles[counter].publishedAt) ?? ""
        }
        return articles
    }
    
}
