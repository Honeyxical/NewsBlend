//  Created by илья on 30.07.23.

import Foundation

// Module Input
protocol FeedModuleInputProtocol {}

// Module Output
protocol FeedModuleOutputProtocol {}

// View Input
protocol FeedViewInputProtocol: AnyObject {
    func setArticles(articles: [PresenterModel])
    func reloadData()
    func loaderIsHidden(_ state: Bool)
    func lottieIsHidden(_ state: Bool)
}

// View Output
protocol FeedViewOutputProtocol: AnyObject {
    func openArticleDetail(article: PresenterModel)
    func openSettings()
    func viewDidLoad()
    func reloadData()
}

// Interactor Input
protocol FeedInteractorInputProtocol {
    func loadData()
    func startUpdateTimer()
    func isFirstStart()
    func setSource(sources: [SourceModel])
    func getUpdateInterval() -> Int
}

// Interactor Output
protocol FeedInteractorOutputProtocol: AnyObject {
    func didReceive(articles: [ArticleModel])
    func didReceiveFail()
}

// Router Input
protocol FeedRouterInputProtocol {
    func openArticleDetail(article: PresenterModel)
    func openSettings()
}

// Router Output
protocol FeedRouterOutputProtocol {}
