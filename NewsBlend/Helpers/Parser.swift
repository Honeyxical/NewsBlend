//  Created by Ilya Benikov on 19.08.23.

import Foundation

class Parser {
    static func parseArticlesByAllSource(sources: [SourceModel], networkService: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        let group = DispatchGroup()
        var articles: [ArticleModel] = []
        
        for source in sources {
            group.enter()
            networkService.getArticlesBySource(queryItems: [
                URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e"),
                URLQueryItem(name: "pageSize", value: "10"),
                URLQueryItem(name: "sources", value: source.id)
            ]) { data in
                if data.isEmpty {
                    group.leave()
                }
                guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
                articles += Converter.setDate(articles: Converter.transferDTOtoModel(articlesArray: articlesDTO.articles))
                group.leave()
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        }
    }
    
    static func parseFeedSource(network: FeedNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void){
        var articles: [ArticleModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.getArticles(queryItems: [
            URLQueryItem(name: "domains", value: "techcrunch.com"),
            URLQueryItem(name: "pageSize", value: "5"),
            URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e")
        ]) { data in
            if data.isEmpty {
                group.leave()
            }
            guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
            articles = Converter.transferDTOtoModel(articlesArray: articlesDTO.articles)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        }
    }
    
    static func parseNBSArticlesBySource(source: SourceModel, network: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        var articles: [ArticleModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.getArticlesBySource(queryItems: [
            URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e"),
            URLQueryItem(name: "pageSize", value: "10"),
            URLQueryItem(name: "sources", value: source.id)
        ]) { data in
            if data.isEmpty {
                group.leave()
            }
            guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
            articles = Converter.transferDTOtoModel(articlesArray: articlesDTO.articles)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        }
    }
    
    static func parseSource(network: SettingNetworkServiceProtocol, completion: @escaping ([SourceModel]) -> Void) {
        var sources: [SourceModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.getSources(queryItems: [
            URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e"),
            URLQueryItem(name: "language", value: "en")
        ]) { data in
            if data.isEmpty {
                group.leave()
            }
            guard let sourcesDTO = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else { return }
            sources = Converter.transferSourceObject(sources: sourcesDTO.sources)
            group.leave()
        }
        
        group.notify(queue: DispatchQueue.main) {
            sources = sources.sorted { $0.name < $1.name }
            completion(sources)
        }
    }
}
