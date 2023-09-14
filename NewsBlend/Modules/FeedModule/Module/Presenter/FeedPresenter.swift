//  Created by илья on 01.08.23.

import Foundation

final class FeedPresenter {
    weak var view: FeedViewInputProtocol?
    private let interactor: FeedInteractorInputProtocol
    private let router: FeedRouterInputProtocol
    private let dateFormatter: DateFormatter = {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
        dateFormatter.locale = Locale(identifier: "en_US")
        return dateFormatter
    }()

    init(view: FeedViewInputProtocol, interactor: FeedInteractorInputProtocol, router: FeedRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
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

    func openArticleDetail(article: ArticleModel) {
        router.openArticleDetail(article: article)
    }
}

extension FeedPresenter: FeedInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        let preparedArticles = prepareArticles(articles: articles)
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

extension FeedPresenter {
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
