//  Created by илья on 03.08.23.

import Foundation

final class DetailPresentor {
    weak var view: DetailViewInputProtocol?
    private let interactor: DetailInteractorInputProtocol
    private let router: DetailRouterInputProtocol
    private let article: ArticleModel

    init(view: DetailViewInputProtocol, interactor: DetailInteractorInputProtocol, router: DetailRouterInputProtocol, article: ArticleModel) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.article = article
    }
}

extension DetailPresentor: DetailInteractorOutputProtocol {}

extension DetailPresentor: DetailViewOutputProtocol {
    func viewDidAppear() {
        view?.setArticle(article: article)
        view?.hideLoader()
    }
}

extension DetailPresentor: DetailRouterOutputProtocol {}
