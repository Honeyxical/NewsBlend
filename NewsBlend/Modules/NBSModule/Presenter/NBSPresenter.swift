//  Created by илья on 13.08.23.

import UIKit

final class NBSPresenter {
    private let interactor: NBSInteractorInputProtocol
    private let router: NBSRouterInputProtocol
    weak var view: NBSViewInputProtocol?

    init(interactor: NBSInteractorInputProtocol, router: NBSRouterInputProtocol, view: NBSViewInputProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension NBSPresenter: NBSInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        view?.setArticle(articles: articles)
    }

    func didReceive(sources: [SourceModel]) {
        view?.setSources(sources: sources)
    }
}

extension NBSPresenter: NBSViewOutputProtocol {
    func openArticleDetail(article: ArticleModel, controller: UIViewController) {
        router.openArticleDetail(article: article, controller: controller)
    }

    func getArticlesBySource(source: SourceModel){
        if  source.name == "All" {
            interactor.getArticlesByAllSource()
        } else {
            interactor.getArticlesBySource(source: source)
        }
    }

    func viewWillAppear() {
        interactor.getSources()
    }
}

extension NBSPresenter: NBSRouterOutputProtocol {}
