//  Created by илья on 13.08.23.

import Foundation
import UIKit

final class NBSAssembly {
    func build() -> UIViewController {
        let interactor = NBSInteractor(networkService: NBSNetworkService(),
                                       cacheService: Storage.shared,
                                       articleParser: ArticleParser(articleConverter: ArticleConverter()),
                                       articleCoder: ArticleCoding(),
                                       sourceCoder: SourceCoding())
        let childView = NBSArticleView()
        let view = NBSViewController(childView: childView)
        let router = NBSRouter()
        let presenter = NBSPresenter(interactor: interactor,
                                     router: router,
                                     view: view,
                                     articlesPreparation: ArticlesPreparations())
        view.output = presenter
        view.moduleInput = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
