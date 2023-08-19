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
            articles = Converter.transferDTOtoModel(articlesArray: articlesParsed.articles)
            articles = Converter.setDate(articles: articles)
            self.output?.didReceive(articles: articles)
        }
    }

    func getArticlesByAllSource() {
        let sources = Converter.decodeSourceObjects(data: storageService.getSources())
        Parser.parseAllSource(sources: sources, networkService: networkService) { articles in
            self.output?.didReceive(articles: articles)
        }
    }

    func getSources() {
        output?.didReceive(sources: Converter.decodeSourceObjects(data: storageService.getSources()))
    }

    func getArticles() {

    }
}

extension NBSInteractor {

}
