//  Created by илья on 03.08.23.

import Foundation

class DetailPresentor {
    let view: DetailViewInputProtocol
    let interactor: DetailInteractorInputProtocol
    let router: DetailRouterInputProtocol

    init(view: DetailViewInputProtocol, interactor: DetailInteractorInputProtocol, router: DetailRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
    }
}

extension DetailPresentor: DetailInteractorOutputProtocol {
    func didReceive(article: Article) {

    }

    func didReceiveFail() {

    }
}

extension DetailPresentor: DetailViewOutputProtocol {
    func loadData() {

    }
}

extension DetailPresentor: DetailRouterOutputProtocol {

}
