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
    func set(hot articles: [Articles])
    func reloadData()
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol FeedViewOutputProtocol {
    func loadData()
    func loadHotData()
}

// Interactor Input
protocol FeedInteractorInputProtocol {
    func loadData()
    func loadHotData()
}

// Interactor Output
protocol FeedInteractorOutputProtocol: AnyObject {
    func didReceive(articles: [Articles])
    func didReceive(hot articles: [Articles])
    func didReceiveFail()
}

// Router Input
protocol FeedRouterInputProtocol {
}

// Router Output
protocol FeedRouterOutputProtocol {
}

protocol FeedNetworkServiceProtocol {
    func getNews(completiton: @escaping(Data) -> Void)
    func getHotNews(country: String, completiton: @escaping(Data) -> Void)
}

protocol FeedCoreDataServiceProtocol{}
