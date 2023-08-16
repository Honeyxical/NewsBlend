//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedAssembly {

    static func build() -> UIViewController {

        let view = FeedViewController(childView: NBSAssembly.build())
        let interactor = FeedInteractor(feedNetworkService: FeedNetworkService(),
                                        feedDataService: FeedCoreDataService())
        let router = FeedRouter()
        let presentor = FeedPresentor(view: view,
                                      interactor: interactor,
                                      router: router)
        interactor.output = presentor
        view.output = presentor
        router.viewController = view
        prepareApp(interactor: interactor)
        return view
    }

    private static func prepareApp(interactor: FeedInteractorInputProtocol) {
        interactor.setSourceIfNeed()
    }
}
