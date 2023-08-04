//  Created by илья on 03.08.23.

import Foundation

class DetailPresentor {
    let view: DetailViewInputProtocol
    let interactor: DetailInteractorInputProtocol
    let router: DetailRouterInputProtocol
    let article: Article

    init(view: DetailViewInputProtocol, interactor: DetailInteractorInputProtocol, router: DetailRouterInputProtocol, article: Article) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.article = article
    }
}

extension DetailPresentor: DetailInteractorOutputProtocol {
    func didReceive() {
    }

    func didReceiveFail() {

    }
}

extension DetailPresentor: DetailViewOutputProtocol {
    func loadData() {
        view.set(article: article)
    }
}

extension DetailPresentor: DetailRouterOutputProtocol {

}
