//  Created by илья on 30.07.23.

import Foundation

// Module Input
public protocol FeedModuleInputProtocol {}

// Module Output
public protocol FeedModuleOutputProtocol {}

// View Input
protocol FeedViewInputProtocol: AnyObject {
    func setArticles(articles: [ArticleModel])
    func reloadData()
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol FeedViewOutputProtocol: AnyObject {
    func openArticleDetail(article: ArticleModel)
    func openSettings()
    func viewDidLoad()
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
    func openArticleDetail(article: ArticleModel)
    func openSettings()
}

// Router Output
protocol FeedRouterOutputProtocol {}
