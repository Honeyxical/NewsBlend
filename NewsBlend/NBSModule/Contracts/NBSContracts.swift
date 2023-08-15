//  Created by илья on 13.08.23.

import Foundation

// Module Input
public protocol NBSModuleInputProtocol {

}

// Module Output
public protocol NBSModuleOutputProtocol {
}

// View Input
protocol NBSViewInputProtocol {
    func set(sources: [SourceModel])
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
}

// Interactor Input
protocol NBSInteractorInputProtocol {
    func getSources()
    func getArticles()
    func getArticlesBySource(source: SourceModel)
}

// Interactor Output
protocol NBSInteractorOutputProtocol: AnyObject {
    func didReceive(sources: [SourceModel])
    func didReceive(articles: [ArticleModel])
    func didReceiveFail()
}

// Router Input
protocol NBSRouterInputProtocol {
}

// Router Output
protocol NBSRouterOutputProtocol {
}

// Data
protocol NBSDataServiceProtocol{
    func getSources() -> Data
}

// Network

protocol NBSNetworkServiceProtocol {
    func getArticlesBySource(source: SourceModel, completion: @escaping (Data) -> Void)
}
