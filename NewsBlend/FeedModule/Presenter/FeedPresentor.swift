//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedPresentor {
    let view: FeedViewInputProtocol
    let interactor: FeedInteractorInputProtocol
    let router: FeedRouterInputProtocol

    init(view: FeedViewInputProtocol, interactor: FeedInteractorInputProtocol, router: FeedRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FeedPresentor: FeedViewOutputProtocol {
    func openSettings() {
        router.openSettings()
    }

    func viewWillApear() {
        interactor.loadData()
        view.showLoader()
    }

    func openArticleDetail(article: Article) {
        router.openArticleDetail(article: article)
    }
}

extension FeedPresentor: FeedInteractorOutputProtocol {
    func didReceive(articles: [Article], hotArticles: [Article]) {
        view.setData(articles: articles, hotArticles: hotArticles)
        view.reloadData()
        view.hideLoader()
    }

    func didReceiveFail() {
        view.displayLotty()
    }
}

extension FeedPresentor: FeedRouterOutputProtocol {}
