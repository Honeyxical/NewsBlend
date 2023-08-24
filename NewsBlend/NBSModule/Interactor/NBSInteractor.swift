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
        let articlesFromCache = Converter.decodeArticleObjects(data: storageService.getArticles())
        Parser.parseNBSArticlesBySource(source: source, network: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.storageService.setArtcles(data: Converter.encodeArticleObjects(articles: articlesFromNetwork))
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getArticlesByAllSource() {
        let sources = Converter.decodeSourceObjects(data: storageService.getSources())
        let articlesFromCache = Converter.decodeArticleObjects(data: storageService.getArticlesByAllSource())
        Parser.parseArticlesByAllSource(sources: sources, networkService: networkService) { articlesFromNetwork in
            if articlesFromNetwork != articlesFromCache && !articlesFromNetwork.isEmpty {
                self.storageService.setArticlesByAllSource(data: Converter.encodeArticleObjects(articles: articlesFromNetwork))
                self.output?.didReceive(articles: articlesFromNetwork)
            } else {
                self.output?.didReceive(articles: articlesFromCache)
            }
        }
    }

    func getSources() {
        var sourcesFromCache = [SourceModel(id: "", name: "All", category: "", language: "", country: "", isSelected: true)]
        sourcesFromCache += Converter.decodeSourceObjects(data: storageService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }

    func getArticles() {

    }
}

extension NBSInteractor {

}
