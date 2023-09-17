//  Created by илья on 13.08.23.

import UIKit

final class NBSPresenter {
    private let interactor: NBSInteractorInputProtocol
    private let router: NBSRouterInputProtocol
    weak var view: NBSViewInputProtocol?
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }()

    init(interactor: NBSInteractorInputProtocol, router: NBSRouterInputProtocol, view: NBSViewInputProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension NBSPresenter: NBSInteractorOutputProtocol {
    func articlesLoaded() {
        interactor.getArticlesByAllSource()
    }
    
    func noInternet() {
        interactor.getArticlesByAllSource()
    }

    func filedParseData() {
        interactor.getArticlesByAllSource()
    }

    func filedUrlConfigure() {
    }

    func didReceive(articles: [ArticleModel]) {
        let preparedArticles = prepareArticles(articles: articles)
        view?.setArticle(articles: preparedArticles)
    }

    func didReceive(sources: [SourceModel]) {
        view?.setSources(sources: sources)
    }
}

extension NBSPresenter: NBSViewOutputProtocol {
    func openArticleDetail(article: ArticleModel) {
        router.openArticleDetail(article: article)
    }

    func getArticlesBySource(source: SourceModel){
        if  source.name == "All" {
            interactor.getArticlesByAllSource()
        } else {
            interactor.getArticlesBySource(source: source)
        }
    }

    func viewDidLoad() {
        interactor.startUpdateTimer()
        interactor.loadData()
    }

    func viewWillAppear() {
        interactor.getSources()
    }
}

extension NBSPresenter: NBSModuleInputProtocol {
    func reloadData() {
        interactor.loadData()
    }
}

extension NBSParser: NBSModuleOutputProtocol {}

extension NBSPresenter {
    func updateSourceAndArticles(newSourceList: [SourceModel]) {
        interactor.loadDataForNewSource(newSourceList: newSourceList)
        interactor.getArticlesByAllSource()
    }

    private func prepareArticles(articles: [ArticleModel]) -> [ArticleModel] {
        var articles = articles
        for (index, var article) in articles.enumerated() {
            let targetDate = dateFormatter.date(from: article.publishedAt ?? "") ?? Date()
            article.timeSincePublication = RelativeDateTimeFormatter().localizedString(for: targetDate, relativeTo: Date())
            articles[index] = article
        }
        return articles
    }
}
