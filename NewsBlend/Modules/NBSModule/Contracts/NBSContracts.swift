//  Created by илья on 13.08.23.

import UIKit

// Module Input
public protocol NBSModuleInputProtocol {}

// Module Output
public protocol NBSModuleOutputProtocol {}

// View Input
protocol NBSViewInputProtocol: AnyObject {
    func setSources(sources: [SourceModel])
    func setArticle(articles: [ArticleModel])
    func showLoader()
    func hideLoader()
    func reloadData()
}

// View Output
protocol NBSViewOutputProtocol: AnyObject {
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
protocol NBSRouterOutputProtocol: AnyObject {}
