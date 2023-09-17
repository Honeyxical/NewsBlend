//  Created by илья on 13.08.23.

import UIKit

final class NBSPresenter {
    private let interactor: NBSInteractorInputProtocol
    private let router: NBSRouterInputProtocol
    weak var view: NBSViewInputProtocol?
    private let articlesPreparation: ArticlesPreparationsProtocol

    init(interactor: NBSInteractorInputProtocol,
         router: NBSRouterInputProtocol,
         view: NBSViewInputProtocol,
         articlesPreparation: ArticlesPreparationsProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
        self.articlesPreparation = articlesPreparation
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
        let preparedArticles = articlesPreparation.prepareArticles(articles: articles)
        view?.setArticle(articles: preparedArticles)
    }

    func didReceive(sources: [SourceModel]) {
        view?.setSources(sources: sources)
    }
}

extension NBSPresenter: NBSViewOutputProtocol {
    func openArticleDetail(article: PresenterModel) {
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
        interactor.getSources()
    }
}

extension NBSPresenter: NBSModuleInputProtocol {
    func reloadData() {
        interactor.loadData()
    }

    func updateSourceAndArticles() {
        interactor.getSources()
        interactor.loadData()
        interactor.getArticlesByAllSource()
    }
}

extension NBSParser: NBSModuleOutputProtocol {}
