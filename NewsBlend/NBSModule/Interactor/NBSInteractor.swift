//  Created by илья on 13.08.23.

import Foundation

class NBSInteractor {
    var output: NBSInteractorOutputProtocol?
    let networkService: NBSNetworkServiceProtocol
    let storageService: NBSDataServiceProtocol

    init(networkService: NBSNetworkServiceProtocol, storageService: NBSDataServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func getArticlesBySource(source: SourceModel) {
        var articles: [ArticleModel] = []
        networkService.getArticlesBySource(source: source) { data in
            guard let articlesParsed = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else {
                self.output?.didReceiveFail()
                return
            }
            articles = self.transferDTOtoModel(articlesArray: articlesParsed.articles)
            articles = self.setDate(articles: articles)
            self.output?.didReceive(articles: articles)
        }
    }

    func getSources() {
        output?.didReceive(sources: decodeObjects(data: storageService.getSources()))
    }

    func getArticles() {

    }
}

extension NBSInteractor {
    private func decodeObjects(data: Data) -> [SourceModel] {
        guard let source = try? NSKeyedUnarchiver.unarchiveTopLevelObjectWithData(data) as? [SourceModel] else { return []}
        return source
    }

    private func encodeObjects(sourceModels: [SourceModel]) -> Data {
        let models = try? NSKeyedArchiver.archivedData(withRootObject: sourceModels, requiringSecureCoding: false)
        guard let models: Data = models else {
            return Data()
        }
        return models
    }

    private func transferDTOtoModel(articlesArray: [Article]) -> [ArticleModel] {
        var articleModels: [ArticleModel] = []
        for article in articlesArray {
            articleModels.append(article.map(article: article))
        }
        return articleModels
    }

    private func setDate(articles: [ArticleModel]) -> [ArticleModel]{
        for counter in 0...articles.count - 1 {
            articles[counter].timeSincePublication = Date().getDifferenceFromNowAndDate( articles[counter].publishedAt) ?? ""
        }
        return articles
    }
}
