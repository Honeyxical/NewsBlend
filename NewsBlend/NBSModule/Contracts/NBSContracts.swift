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
    func set(article: ArticleModel)
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol NBSViewOutputProtocol {
    func viewDidAppear()
}

// Interactor Input
protocol NBSInteractorInputProtocol {
    func loadData()
}

// Interactor Output
protocol NBSInteractorOutputProtocol: AnyObject {
    func didReceive()
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

}

// Network

protocol NBSNetworkServiceProtocol {

}
