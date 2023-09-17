//  Created by илья on 03.08.23.

import Foundation

final class DetailPresenter {
    weak var view: DetailViewInputProtocol?
    private let interactor: DetailInteractorInputProtocol
    private let router: DetailRouterInputProtocol
    private let article: PresenterModel

    init(view: DetailViewInputProtocol, interactor: DetailInteractorInputProtocol, router: DetailRouterInputProtocol, article: PresenterModel) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.article = article
    }
}

extension DetailPresenter: DetailInteractorOutputProtocol {}

extension DetailPresenter: DetailViewOutputProtocol {
    func viewDidLoad() {
        view?.setArticle(article: article)
    }
}

extension DetailPresenter: DetailRouterOutputProtocol {}
