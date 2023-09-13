//  Created by илья on 13.08.23.

import UIKit

// Module Input
protocol NBSModuleInputProtocol {}

// Module Output
protocol NBSModuleOutputProtocol {}

// View Input
protocol NBSViewInputProtocol: AnyObject {
    func setSources(sources: [SourceModel])
    func setArticle(articles: [ArticleModel])
    func showLoader()
    func hideLoader()
}

// View Output
protocol NBSViewOutputProtocol: AnyObject {
    func viewWillAppear()
    func getArticlesBySource(source: SourceModel)
    func openArticleDetail(article: ArticleModel)
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
}

// Router Input
protocol NBSRouterInputProtocol {
    func openArticleDetail(article: ArticleModel)
}

// Router Output
protocol NBSRouterOutputProtocol: AnyObject {}
