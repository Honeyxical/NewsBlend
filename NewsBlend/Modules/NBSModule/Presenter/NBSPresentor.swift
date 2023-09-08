//  Created by илья on 13.08.23.

import UIKit

final class NBSPresentor {
    let interactor: NBSInteractorInputProtocol
    let router: NBSRouterInputProtocol
    weak var view: NBSViewInputProtocol?

    init(interactor: NBSInteractorInputProtocol, router: NBSRouterInputProtocol, view: NBSViewInputProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension NBSPresentor: NBSInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        view?.setArticle(articles: articles)
    }

    func didReceive(sources: [SourceModel]) {
        view?.setSources(sources: sources)
    }
}

extension NBSPresentor: NBSViewOutputProtocol {
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

    func viewDidLoad() {
        viewDidAppear()
    }

    func viewDidAppear() {
        interactor.getSources()
    }
}

extension NBSPresentor: NBSRouterOutputProtocol {}
