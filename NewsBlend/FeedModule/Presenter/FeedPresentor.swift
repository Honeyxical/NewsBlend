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

    func loadHotData() {
        interactor.loadHotData()
    }
}

extension FeedPresentor: FeedInteractorOutputProtocol {
    func didReceive(articles: [Article]) {
        view.set(articles: articles)
        view.reloadData()
    }

    func didReceive(hot articles: [Article]) {
        view.set(hot: articles)
        view.reloadData()
    }

    func didReceiveFail() {
        view.displayLotty()
    }
}

extension FeedPresentor: FeedModuleInputProtocol {}

extension FeedPresentor: FeedRouterOutputProtocol {}
