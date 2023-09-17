//  Created by илья on 13.08.23.

import Foundation
import UIKit

final class NBSAssembly {
    static func build(newSourcesList: [SourceModel]) -> UIViewController {
        let interactor = NBSInteractor(networkService: NBSNetworkService(),
                                       cacheService: Storage.shared,
                                       parser: NBSParser(articleConverter: NBSArticleConverter()),
                                       articleConverter: NBSArticleConverter(),
                                       articleCoder: ArticleCoding(),
                                       sourceCoder: SourceCoding(),
                                       sourceConverter: NBSSourceConverter())
        let childView = NBSArticleView()
        let view = NBSViewController(childView: childView)
        let router = NBSRouter()
        let presenter = NBSPresenter(interactor: interactor,
                                     router: router,
                                     view: view)
        if  !newSourcesList.isEmpty {
            presenter.updateSourceAndArticles(newSourceList: newSourcesList)
        }
        view.output = presenter
        view.moduleInput = presenter
        interactor.output = presenter
        router.viewController = view
        return view
    }
}
