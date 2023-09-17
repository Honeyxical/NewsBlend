//  Created by илья on 13.08.23.

import UIKit

// Module Input
protocol NBSModuleInputProtocol: AnyObject {
    func reloadData()
    func updateSourceAndArticles()
}

// Module Output
protocol NBSModuleOutputProtocol: AnyObject {}

// View Input
protocol NBSViewInputProtocol: AnyObject {
    func setSources(sources: [SourceModel])
    func setArticle(articles: [PresenterModel])
}

// View Output
protocol NBSViewOutputProtocol: AnyObject {
    func viewDidLoad()
    func getArticlesBySource(source: SourceModel)
    func openArticleDetail(article: PresenterModel)
}

// Interactor Input
protocol NBSInteractorInputProtocol {
    func getSources()
    func getArticlesBySource(source: SourceModel)
    func getArticlesByAllSource()
    func startUpdateTimer()
    func loadData()
}

// Interactor Output
protocol NBSInteractorOutputProtocol: AnyObject {
    func didReceive(sources: [SourceModel])
    func didReceive(articles: [ArticleModel])
    func filedParseData()
    func articlesLoaded()
}

// Router Input
protocol NBSRouterInputProtocol {
    func openArticleDetail(article: PresenterModel)
}

// Router Output
protocol NBSRouterOutputProtocol: AnyObject {}
