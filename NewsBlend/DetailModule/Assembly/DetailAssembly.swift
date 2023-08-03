//  Created by илья on 03.08.23.

import Foundation
import UIKit

class DetailAssembly {
    static func build() -> UIViewController {
        let view = DetailView()
        let interactor = DetailInteractor(detailDataService: DetailCoreDataService())
        let router = DetailRouter()
        let presentor = DetailPresentor(view: view,
                                        interactor: interactor,
                                        router: router)
        router.output = presentor
        interactor.output = presentor
        view.output = presentor
        return view
    }
}
