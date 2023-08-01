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
    func set(articles: [Articles])
    func reloadData()
    func showLoader()
    func hideLoader()
}

// View Output
protocol FeedViewOutputProtocol {
    func loadData()
}

// Interactor Input
protocol FeedInteractorInputProtocol {
    func loadData()
}

// Interactor Output
protocol FeedInteractorOutputProtocol: AnyObject {
    func didReceive(articles: [Articles])
    func didReceiveFail()
}

// Router Input
protocol FeedRouterInputProtocol {
}

// Router Output
protocol FeedRouterOutputProtocol {
}

protocol FeedNetworkServiceProtocol {
    func getNewsFromNewsApi(completiton: @escaping(Data) -> Void)
}

protocol FeedCoreDataServiceProtocol{}
