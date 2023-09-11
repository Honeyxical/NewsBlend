//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedAssembly {
    static func build() -> UIViewController {
        let view = FeedViewController(childView: NBSAssembly.build())
        let articleConverter = ArticleConverter()
        let sourceConverter = SourceConverter()
        let interactor = FeedInteractor(networkService: FeedNetworkService(),
                                        cacheService: FeedUserDefaultsService(),
                                        parser: Parser(articleConverter: articleConverter, sourceConverter: sourceConverter),
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
                                                                          isSelected: false),
                                        articleConverter: articleConverter)
        let router = FeedRouter()
        let presenter = FeedPresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        interactor.output = presenter
        view.output = presenter
        router.viewController = view
        return view
    }
}
