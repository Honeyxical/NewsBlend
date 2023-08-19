//  Created by илья on 03.08.23.

import Foundation
import UIKit

class DetailAssembly {
    static func build(artile: ArticleModel) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor(detailDataService: DetailCoreDataService())
        let router = DetailRouter()
        let presentor = DetailPresentor(view: view,
                                        interactor: interactor,
                                        router: router, article: artile)
        router.output = presentor
        interactor.output = presentor
        view.output = presentor
        router.feedRouter = FeedRouter()
        return view
    }
}
