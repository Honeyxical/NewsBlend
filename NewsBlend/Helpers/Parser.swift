//  Created by Ilya Benikov on 19.08.23.

import Foundation

protocol ParserProtocol {
    func parseArticlesByAllSource(sources: [SourceModel], pageSize: Int, networkService: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void)
    func parseFeedSource(source: SourceModel, articlesCount: Int, network: FeedNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void)
    func parseNBSArticlesBySource(source: SourceModel, pageSize: Int, network: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void)
    func parseSource(defaultLanguage: String, network: SettingNetworkServiceProtocol, completion: @escaping ([SourceModel]) -> Void)
}

class Parser: ParserProtocol {
    func parseArticlesByAllSource(sources: [SourceModel], pageSize: Int, networkService: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        let group = DispatchGroup()
        var articles: [ArticleModel] = []
        
        for source in sources {
            group.enter()
            networkService.getArticlesBySource(source: source, pageSize: pageSize) { data in
                if data.isEmpty {
                    group.leave()
                    return
                }
                guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
                articles += Converter.setDate(articles: Converter.transferDTOtoModel(articlesArray: articlesDTO.articles))
                group.leave()
            }
//        }failure: {
//
//            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        }
    }
    
    func parseFeedSource(source: SourceModel, articlesCount: Int, network: FeedNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        network.getArticles(source: source, articlesCount: articlesCount){ data in
            var articles: [ArticleModel] = []
            if data.isEmpty {
                completion(articles)
            }
            guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
            articles = Converter.transferDTOtoModel(articlesArray: articlesDTO.articles)
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        }
    }
    
    func parseNBSArticlesBySource(source: SourceModel, pageSize: Int, network: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        var articles: [ArticleModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.getArticlesBySource(source: source, pageSize: pageSize) { data in
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
    
    func parseSource(defaultLanguage: String, network: SettingNetworkServiceProtocol, completion: @escaping ([SourceModel]) -> Void) {
        var sources: [SourceModel] = []
        let group = DispatchGroup()
        
        group.enter()
        network.getSources(sourceLanguage: defaultLanguage) { data in
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
