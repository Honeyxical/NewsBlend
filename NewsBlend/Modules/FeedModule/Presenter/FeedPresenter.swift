//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedPresenter {
    weak var view: FeedViewInputProtocol?
    private let interactor: FeedInteractorInputProtocol
    private let router: FeedRouterInputProtocol

    init(view: FeedViewInputProtocol, interactor: FeedInteractorInputProtocol, router: FeedRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FeedPresenter: FeedViewOutputProtocol {
    func viewDidLoad() {
        interactor.startUpdateDemon()
        interactor.loadData()
    }

    func openSettings() {
        router.openSettings()
    }

    func openArticleDetail(article: ArticleModel) {
        router.openArticleDetail(article: article)
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        view?.setArticles(articles: articles)
        view?.reloadData()
        view?.hideLoader()
    }

    func didReceiveFail() {
        view?.displayLotty()
    }
}

extension FeedPresenter: FeedRouterOutputProtocol {}
