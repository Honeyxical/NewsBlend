//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedAssembly {
    static func build() -> UIViewController {
        let view = FeedViewController(childView: NBSAssembly.build())
        let interactor = FeedInteractor(networkService: FeedNetworkService(),
                                        cacheService: FeedUserDefaultsService(),
                                        parser: Parser(),
                                        initialSource: SourceModel(id: "abc-news",
                                                                   name: "ABC News",
                                                                   category: "",
                                                                   language: "",
                                                                   country: "",
                                                                   isSelected: true),
                                        defaultSourceHotNews: SourceModel(id: "techcrunch.com",
                                                                          name: "",
                                                                          category: "",
                                                                          language: "",
                                                                          country: "",
                                                                          isSelected: false))
        let router = FeedRouter()
        let presentor = FeedPresentor(view: view,
                                      interactor: interactor,
                                      router: router)
        interactor.output = presentor
        view.output = presentor
        router.viewController = view
        isFirstStart(interactor: interactor)
        return view
    }

    // сделано через !вилкойВГлаз. На будущее: Нужно вынести в модуль конфигурации
    private static func isFirstStart(interactor: FeedInteractorInputProtocol) {
        interactor.isFirstStart()
    }
}
