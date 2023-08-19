//  Created by илья on 13.08.23.

import Foundation
import UIKit

class NBSAssembly {
    static func build() -> UIViewController {
        let interactor = NBSInteractor(networkService: NBSNetworService(), storageService: NBSUserDefaultsService())
        let view = NBSViewController()
        let router = NBSRouter()
        let presentor = NBSPresentor(interactor: interactor, router: router, view: view)

        view.output = presentor
        interactor.output = presentor
        router.output = presentor
        return view
    }
}
