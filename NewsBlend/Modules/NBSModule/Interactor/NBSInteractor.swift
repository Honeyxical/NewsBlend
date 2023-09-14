//  Created by илья on 13.08.23.

import Foundation

final class NBSInteractor {
    weak var output: NBSInteractorOutputProtocol?
    private let networkService: NBSNetworkServiceProtocol
    private let cacheService: NBSStorageProtocol
    private let parser: NBSParserProtocol
    private let articleConverter: NBSArticleConverterProtocol
    private let articleCoder: ArticleCodingProtocol
    private let sourceCoder: SourceCodingProtocol
    private let sourceConverter: NBSSourceConverterProtocol
    
    private let defaultPageSize = 10

    init(networkService: NBSNetworkServiceProtocol,
         cacheService: NBSStorageProtocol,
         parser: NBSParserProtocol,
         articleConverter: NBSArticleConverterProtocol,
         articleCoder: ArticleCodingProtocol,
         sourceCoder: SourceCodingProtocol,
         sourceConverter: NBSSourceConverterProtocol) {
        self.networkService = networkService
        self.cacheService = cacheService
        self.parser = parser
        self.articleConverter = articleConverter
        self.articleCoder = articleCoder
        self.sourceCoder = sourceCoder
        self.sourceConverter = sourceConverter
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func loadDataForNewSource(newSourceList: [SourceModel]) {
        for source in newSourceList {
            networkService.getArticlesBySource(source: source, pageSize: defaultPageSize) { result in
                switch result {
                case .success:
                    guard let data = try? result.get() else { return }
                    let parsedArticlesFromNetwork = self.parser.parseArticle(data: data)
                    let encodedArticle = self.articleCoder.encodeArticleObjects(articles: parsedArticlesFromNetwork)
                    self.cacheService.setArticles(data: encodedArticle, source: source.id)
                case .failure:
                    print("fail") // Обработать ошибку
                }
            }
        }
    }

    func getArticlesBySource(source: SourceModel) {
        let articlesFromCache = articleCoder.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
        output?.didReceive(articles: articlesFromCache)
    }

    func getArticlesByAllSource() {
        let sources = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        var articlesFromCache: [ArticleModel] = []
        for source in sources {
            let article = articleCoder.decodeArticleObjects(data: cacheService.getArticles(source: source.id))
            articlesFromCache.append(contentsOf: article)
        }
        self.output?.didReceive(articles: articlesFromCache)
    }

    func loadData() {
        let sources = sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        for source in sources {
            networkService.getArticlesBySource(source: source, pageSize: defaultPageSize) { result in
                switch result {
                case .success:
                    guard let data = try? result.get() else { return }
                    let parsedArticlesFromNetwork = self.parser.parseArticle(data: data)
                    let encodedArticle = self.articleCoder.encodeArticleObjects(articles: parsedArticlesFromNetwork)
                    self.cacheService.setArticles(data: encodedArticle, source: source.id)
                case .failure:
                    print("fail") // Обработать ошибку
                }
            }
        }
    }
        
    func getSources() {
        var sourcesFromCache = [SourceModel(id: "all", name: "All", category: "", language: "", country: "", isSelected: true)]
        sourcesFromCache += sourceCoder.decodeSourceObjects(data: cacheService.getSources())
        output?.didReceive(sources: sourcesFromCache)
    }

    func startUpdateTimer() {
        let timer = Timer.scheduledTimer(withTimeInterval: Double(getInterval()), repeats: true) { _ in
            self.loadData()
        }
        RunLoop.current.add(timer, forMode: .common)
    }

    private func getInterval() -> Int{
        let interval = cacheService.getUpdateInterval()
        if interval == 0 {
            return 600
        }
        return interval
    }
}
