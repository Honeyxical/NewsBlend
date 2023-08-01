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
        feedNetworkService.getNewsFromNewsApi { data in
            guard let news = try? JSONDecoder().decode(NewsModel.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            self.output?.didReceive(articles: news.articles)
        }
    }
}
