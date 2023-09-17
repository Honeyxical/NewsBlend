//  Created by илья on 03.08.23.

import Foundation
import UIKit

final class DetailAssembly {
    func build(artiсle: PresenterModel) -> UIViewController {
        let view = DetailViewController()
        let interactor = DetailInteractor()
        let router = DetailRouter()
        let presenter = DetailPresenter(view: view,
                                        interactor: interactor,
                                        router: router,
                                        article: artiсle)
        router.output = presenter
        interactor.output = presenter
        view.output = presenter
        return view
    }
}
