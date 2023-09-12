//  Created by илья on 13.08.23.

import Foundation
import UIKit

final class NBSAssembly {
    static func build() -> UIViewController {
        let interactor = NBSInteractor(networkService: NBSNetworkService(),
                                       cacheService: Storage.shared,
                                       parser: NBSParser(articleConverter: NBSArticleConverter()),
                                       articleConverter: NBSArticleConverter(),
                                       articleCoder: ArticleCoding(),
                                       sourceCoder: SourceCoding(),
                                       sourceConverter: NBSSourceConverter())
        let view = NBSViewController()
        let router = NBSRouter()
        let presenter = NBSPresenter(interactor: interactor,
                                     router: router,
                                     view: view)

        view.output = presenter
        interactor.output = presenter
        router.output = presenter
        return view
    }
}
