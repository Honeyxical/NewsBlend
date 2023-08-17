//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedPresentor {
    let view: FeedViewInputProtocol
    let interactor: FeedInteractorInputProtocol
    let router: FeedRouterInputProtocol
    private let asyncThread = DispatchQueue.global(qos: .background)

    init(view: FeedViewInputProtocol, interactor: FeedInteractorInputProtocol, router: FeedRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        startUpdateDemon()
    }
}

extension FeedPresentor: FeedViewOutputProtocol {
    func openSettings() {
        router.openSettings()
    }

    func viewWillApear() {
        interactor.loadData()
        view.showLoader()
    }

    func openArticleDetail(article: ArticleModel) {
        router.openArticleDetail(article: article)
    }
}

extension FeedPresentor: FeedInteractorOutputProtocol {
    func didReceive(articles: [ArticleModel]) {
        view.setData(articles: articles)
        view.reloadData()
        view.hideLoader()
    }

    func didReceiveFail() {
        view.displayLotty()
    }
}

extension FeedPresentor {
    func startUpdateTimer() {
        
    }
}

extension FeedPresentor: FeedRouterOutputProtocol {}

extension FeedPresentor {
    private func startUpdateDemon() {
        asyncThread.async {
            repeat {
                sleep(UInt32(self.interactor.getUpdateInterval()))
                self.interactor.loadData()
            } while (true)
        }
    }
}
