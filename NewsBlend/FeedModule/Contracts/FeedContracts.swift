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
    func setData(articles: [ArticleModel])
    func reloadData()
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol FeedViewOutputProtocol {
    func viewWillApear()
    func openArticleDetail(article: ArticleModel)
    func openSettings()
}

// Interactor Input
protocol FeedInteractorInputProtocol {
    func loadData()
    func isFirstStart()
    func setSource(sources: [SourceModel])
    func setUpdateInterval(interval: Int)
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
protocol FeedRouterOutputProtocol {
}

protocol FeedNetworkServiceProtocol {
    func getNews(completion: @escaping(Data) -> Void)
//    func getHotNews(country: String, completion: @escaping(Data) -> Void)
}

protocol FeedCoreDataServiceProtocol{
    func getSource() -> Data
    func setSource(data: Data)
    func getInterval() -> Int
    func setInterval(interval: Int)
    func getInitValue() -> Bool
    func setInitValue(initValue: Bool)
}
