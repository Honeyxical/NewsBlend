//  Created by илья on 01.08.23.

import Foundation

final class FeedPresenter {
    weak var view: FeedViewInputProtocol?
    private let interactor: FeedInteractorInputProtocol
    private let router: FeedRouterInputProtocol
    private let articlesPreparation: ArticlesPreparationsProtocol

    init(view: FeedViewInputProtocol,
         interactor: FeedInteractorInputProtocol,
         router: FeedRouterInputProtocol,
         articlesPreparation: ArticlesPreparationsProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.articlesPreparation = articlesPreparation
    }
}

extension FeedPresenter: FeedViewOutputProtocol {
    func viewDidLoad() {
        view?.showLoader()
        interactor.startUpdateTimer()
        interactor.loadData()
        interactor.isFirstStart()
    }

    func reloadData() {
        interactor.loadData()
        view?.hideLottie()
        view?.showLoader()
    }

    func openSettings() {
        router.openSettings()
    }

    func openArticleDetail(article: PresenterModel) {
        router.openArticleDetail(article: article)
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        let preparedArticles = articlesPreparation.prepareArticles(articles: articles)
        view?.setArticles(articles: preparedArticles)
        view?.reloadData()
        view?.hideLoader()
    }

    func didReceiveFail() {
        view?.hideLoader()
        view?.displayLottie()
    }
}

extension FeedPresenter: FeedRouterOutputProtocol {}
