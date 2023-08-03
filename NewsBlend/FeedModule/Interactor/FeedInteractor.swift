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
        feedNetworkService.getNews { data in
            guard let news = try? JSONDecoder().decode(NewsModel.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            self.output?.didReceive(articles: self.setDate(articles: news.articles))
        }
    }

    func loadHotData() {
        feedNetworkService.getHotNews(country: "us") { data in
            guard let news = try? JSONDecoder().decode(NewsModel.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            self.output?.didReceive(hot: self.setDate(articles: news.articles))
        }
    }
    
    private func setDate(articles: [Articles]) -> [Articles]{
        var articles = articles
        for counter in 0...articles.count - 1 {
            articles[counter].publishedAt = Date().getDifferenceFromNowAndDate( articles[counter].publishedAt) ?? ""
        }
        return articles
    }
    
}
