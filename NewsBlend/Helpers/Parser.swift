//  Created by Ilya Benikov on 19.08.23.

import Foundation

protocol ParserProtocol {
    func parseArticlesByAllSource(sources: [SourceModel], pageSize: Int, networkService: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void)
    func parseFeedSource(source: SourceModel, articlesCount: Int, network: FeedNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void)
    func parseNBSArticlesBySource(source: SourceModel, pageSize: Int, network: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void)
    func parseSource(defaultLanguage: String, network: SettingNetworkServiceProtocol, completion: @escaping ([SourceModel]) -> Void)
}

final class Parser: ParserProtocol {
    private let articleConverter: ArticleConverterProtocol
    private let sourceConverter: SourceConverterProtocol
    
    init(articleConverter: ArticleConverterProtocol, sourceConverter: SourceConverterProtocol) {
        self.articleConverter = articleConverter
        self.sourceConverter = sourceConverter
    }
    
    func parseArticlesByAllSource(sources: [SourceModel], pageSize: Int, networkService: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        let group = DispatchGroup()
        var articles: [ArticleModel] = []
        
        for source in sources {
            group.enter()
            networkService.getArticlesBySource(source: source, pageSize: pageSize) { [self] data in
                guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
                articles += articleConverter.setDate(articles: articleConverter.transferDTOtoModel(articlesArray: articlesDTO.articles))
                group.leave()
            } failure: {
                group.leave()
                return
            }
        }
        
        group.notify(queue: DispatchQueue.main) {
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        }
    }
    
    func parseFeedSource(source: SourceModel, articlesCount: Int, network: FeedNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        network.getArticles(source: source, articlesCount: articlesCount){ data in
            var articles: [ArticleModel] = []
            guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
            articles = self.articleConverter.transferDTOtoModel(articlesArray: articlesDTO.articles)
            articles = articles.sorted { $0.publishedAt > $1.publishedAt }
            completion(articles)
        } failure: {
            completion([])
        }
    }
    
    func parseNBSArticlesBySource(source: SourceModel, pageSize: Int, network: NBSNetworkServiceProtocol, completion: @escaping ([ArticleModel]) -> Void) {
        var articles: [ArticleModel] = []

        network.getArticlesBySource(source: source, pageSize: pageSize) { data in
            guard let articlesDTO = try? JSONDecoder().decode(NewsModelDTO.self, from: data) else { return }
            articles = self.articleConverter.transferDTOtoModel(articlesArray: articlesDTO.articles)
            completion(articles)
        } failure: {
            completion(articles)
        }
    }
    
    func parseSource(defaultLanguage: String, network: SettingNetworkServiceProtocol, completion: @escaping ([SourceModel]) -> Void) {
        var sources: [SourceModel] = []

        network.getSources(sourceLanguage: defaultLanguage) { data in
            guard let sourcesDTO = try? JSONDecoder().decode(SourcesModelDTO.self, from: data) else { return }
            sources = self.sourceConverter.transferSourceObject(sources: sourcesDTO.sources)
            completion(sources)
        } failure: {
            completion(sources)
        }
    }
}
