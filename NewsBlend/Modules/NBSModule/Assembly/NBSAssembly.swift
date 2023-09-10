//  Created by илья on 13.08.23.

import Foundation
import UIKit

class NBSAssembly {
    static func build() -> UIViewController {
        let interactor = NBSInteractor(networkService: NBSNetworService(),
                                       cacheService: NBSUserDefaultsService(),
                                       parser: Parser(),
                                       articleConverter: ArticleConverter(),
                                       sourceConverter: SourceConverter())
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
