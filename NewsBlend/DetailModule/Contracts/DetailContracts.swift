//  Created by илья on 03.08.23.

import Foundation

    // Module Input
    public protocol DetailModuleInputProtocol {

    }

    // Module Output
    public protocol DetailModuleOutputProtocol {
    }

    // View Input
    protocol DetailViewInputProtocol {
        func setArticle(article: ArticleModel)
        func showLoader()
        func hideLoader()
        func displayLotty()
    }

    // View Output
    protocol DetailViewOutputProtocol {
        func viewDidAppear()
    }

    // Interactor Input
    protocol DetailInteractorInputProtocol {
        func loadData()
    }

    // Interactor Output
    protocol DetailInteractorOutputProtocol: AnyObject {
        func didReceive()
        func didReceiveFail()
    }

    // Router Input
    protocol DetailRouterInputProtocol {
    }

    // Router Output
    protocol DetailRouterOutputProtocol {
    }

    protocol DetailCoreDataServiceProtocol{

    }
