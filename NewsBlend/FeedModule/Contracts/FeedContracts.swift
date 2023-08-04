//  Created by илья on 30.07.23.

import Foundation

// Module Input
public protocol FeedModuleInputProtocol {
}

// Module Output
public protocol FeedModuleOutputProtocol {
}

// View Input
protocol FeedViewInputProtocol {
    func setData(articles: [Article], hotArticles: [Article])
    func reloadData()
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol FeedViewOutputProtocol {
    func viewWillApear()
    func openArticleDetail(article: Article)
}

// Interactor Input
protocol FeedInteractorInputProtocol {
    func loadData()
}

// Interactor Output
protocol FeedInteractorOutputProtocol: AnyObject {
    func didReceive(articles: [Article], hotArticles: [Article])
    func didReceiveFail()
}

// Router Input
protocol FeedRouterInputProtocol {
    func openArticleDetail(article: Article)
}

// Router Output
protocol FeedRouterOutputProtocol {
}

protocol FeedNetworkServiceProtocol {
    func getNews(completiton: @escaping(Data) -> Void)
    func getHotNews(country: String, completiton: @escaping(Data) -> Void)
}

protocol FeedCoreDataServiceProtocol{}
