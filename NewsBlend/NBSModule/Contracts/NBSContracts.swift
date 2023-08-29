//  Created by илья on 13.08.23.

import UIKit

// Module Input
public protocol NBSModuleInputProtocol {

}

// Module Output
public protocol NBSModuleOutputProtocol {
}

// View Input
protocol NBSViewInputProtocol {
    func setSources(sources: [SourceModel])
    func setArticle(articles: [ArticleModel])
    func showLoader()
    func hideLoader()
    func displayLotty()
    func reloadData()
}

// View Output
protocol NBSViewOutputProtocol {
    func viewDidAppear()
    func viewDidLoad()
    func getArticlesBySource(source: SourceModel)
    func openArticleDetail(article: ArticleModel, controller: UIViewController)
}

// Interactor Input
protocol NBSInteractorInputProtocol {
    func getSources()
    func getArticlesBySource(source: SourceModel)
    func getArticlesByAllSource()
}

// Interactor Output
protocol NBSInteractorOutputProtocol: AnyObject {
    func didReceive(sources: [SourceModel])
    func didReceive(articles: [ArticleModel])
    func didReceiveFail()
}

// Router Input
protocol NBSRouterInputProtocol {
    func openArticleDetail(article: ArticleModel, controller: UIViewController)
}

// Router Output
protocol NBSRouterOutputProtocol {
}

// Data
protocol NBSDataServiceProtocol{
    func getSources() -> Data
    func setArtcles(data: Data, source: String)
    func getArticles(source: String) -> Data
}

// Network

protocol NBSNetworkServiceProtocol {
    func getArticlesBySource(queryItems: [URLQueryItem], completion: @escaping (Data) -> Void)
}
