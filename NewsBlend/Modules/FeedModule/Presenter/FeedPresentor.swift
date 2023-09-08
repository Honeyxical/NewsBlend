//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedPresentor {
    weak var view: FeedViewInputProtocol?
    let interactor: FeedInteractorInputProtocol
    let router: FeedRouterInputProtocol

    init(view: FeedViewInputProtocol, interactor: FeedInteractorInputProtocol, router: FeedRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FeedPresentor: FeedViewOutputProtocol {
    func viewDidLoad() {
        interactor.startUpdateDemon()
    }

    func openSettings() {
        router.openSettings()
    }

    func viewWillApear() {
        interactor.loadData()
        view?.showLoader()
    }

    func openArticleDetail(article: ArticleModel) {
        router.openArticleDetail(article: article)
    }
}

extension FeedPresentor: FeedInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        view?.setArticles(articles: articles)
        view?.reloadData()
        view?.hideLoader()
    }

    func didReceiveFail() {
        view?.displayLotty()
    }
}

extension FeedPresentor: FeedRouterOutputProtocol {}
