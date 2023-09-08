//  Created by илья on 03.08.23.

import Foundation

// Module Input
public protocol DetailModuleInputProtocol {}

// Module Output
public protocol DetailModuleOutputProtocol {}

// View Input
protocol DetailViewInputProtocol: AnyObject {
    func setArticle(article: ArticleModel)
    func showLoader()
    func hideLoader()
}

// View Output
protocol DetailViewOutputProtocol: AnyObject {
    func viewDidAppear()
}

// Interactor Input
protocol DetailInteractorInputProtocol: AnyObject {}

// Interactor Output
protocol DetailInteractorOutputProtocol: AnyObject {}

// Router Input
protocol DetailRouterInputProtocol: AnyObject {}

// Router Output
protocol DetailRouterOutputProtocol: AnyObject {}
