//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedPresentor {
    let view: FeedViewInputProtocol
    let interactor: FeedInteractorInputProtocol
    let router: FeedRouterInputProtocol

    init(view: FeedViewInputProtocol, interactor: FeedInteractorInputProtocol, router: FeedRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension FeedPresentor: FeedViewOutputProtocol {
    func loadData() {
        interactor.loadData()
    }
}

extension FeedPresentor: FeedInteractorOutputProtocol {
    func didReceive(articles: [Articles]) {
        view.set(articles: articles)
        view.reloadData()
    }

    func didReceiveFail() {
        print("Fail get data")
    }
}

extension FeedPresentor: FeedModuleInputProtocol {}

extension FeedPresentor: FeedRouterOutputProtocol {}
