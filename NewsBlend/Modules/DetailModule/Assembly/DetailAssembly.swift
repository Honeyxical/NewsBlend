//  Created by илья on 03.08.23.

import Foundation
import UIKit

final class DetailAssembly {
    static func build(artile: ArticleModel) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor(cacheService: DetailCoreDataService())
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view,
                                        interactor: interactor,
                                        router: router, article: artile)
        router.output = presenter
        interactor.output = presenter
        view.output = presenter
        return view
    }
}
