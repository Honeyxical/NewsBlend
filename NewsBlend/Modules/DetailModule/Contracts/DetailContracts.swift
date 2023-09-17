//  Created by илья on 03.08.23.

import Foundation

// Module Input
protocol DetailModuleInputProtocol {}

// Module Output
protocol DetailModuleOutputProtocol {}

// View Input
protocol DetailViewInputProtocol: AnyObject {
    func setArticle(article: PresenterModel)
}

// View Output
protocol DetailViewOutputProtocol: AnyObject {
    func viewDidLoad()
}

// Interactor Input
protocol DetailInteractorInputProtocol: AnyObject {}

// Interactor Output
protocol DetailInteractorOutputProtocol: AnyObject {}

// Router Input
protocol DetailRouterInputProtocol: AnyObject {}

// Router Output
protocol DetailRouterOutputProtocol: AnyObject {}
