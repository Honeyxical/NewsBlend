//  Created by илья on 01.08.23.

import Foundation

final class FeedInteractor {
    weak var output: FeedInteractorOutputProtocol?
    let feedNetworkService: FeedNetworkServiceProtocol
    let feedDataService: FeedCoreDataServiceProtocol
    private let initialSource = SourceModel(id: "abc-news", name: "ABC News", category: "", language: "", country: "", isSelected: true)
    
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
            hotArticles = self.transferDTOtoModel(articlesArray: hotNews.articles)
            hotArticles = self.setDate(articles: hotArticles)
            self.output?.didReceive(articles: articles, hotArticles: hotArticles)
        }

        feedNetworkService.getNews { data in
            guard let news = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            articles = self.transferDTOtoModel(articlesArray: news.articles)
            articles = self.setDate(articles: articles)
            self.output?.didReceive(articles: articles, hotArticles: hotArticles)
        }
    }

    func setSourceIfNeed() {
        if decodeSource(data: feedDataService.getSource()).isEmpty {
            let initialSource = encodeObjects(sourceModel: [initialSource])
            feedDataService.setSource(data: initialSource)
        }
    }
}

extension FeedInteractor {
    private func setDate(articles: [ArticleModel]) -> [ArticleModel]{
        for counter in 0...articles.count - 1 {
            articles[counter].timeSincePublication = Date().getDifferenceFromNowAndDate( articles[counter].publishedAt) ?? ""
        }
        return articles
    }

    private func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }

    private func decodeSource(data: Data) -> [SourceModel] {
        guard let source = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SourceModel] else { return []}
        return source
    }

    private func encodeObjects(sourceModel: [SourceModel]) -> Data {
        let models = try? NSKeyedArchiver.archivedData(withRootObject: sourceModel, requiringSecureCoding: false)
        guard let models: Data = models else {
            return Data()
        }
        return models
    }
}
