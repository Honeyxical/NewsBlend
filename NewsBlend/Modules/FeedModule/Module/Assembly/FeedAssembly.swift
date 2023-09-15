//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedAssembly {
    static func build() -> UIViewController {
        let lottieUnknownError = LottieUnknownError()
        let view = FeedViewController(childView: NBSAssembly.build(newSourcesList: []), lottieChildView: lottieUnknownError, loader: Loader())
        let interactor = FeedInteractor(networkService: FeedNetworkService(),
                                        cacheService: Storage.shared,
                                        parser: FeedParser(converter: FeedArticleConverter()),
                                        articleCoder: ArticleCoding(),
                                        sourceCoder: SourceCoding(),
                                        initialSource: SourceModel(id: "abc-news",
                                                                   name: "ABC News",
                                                                   isSelected: true),
                                        defaultSourceHotNews: SourceModel(id: "techcrunch.com",
                                                                          name: "TechCrunch",
                                                                          isSelected: false))
        let router = FeedRouter()
        let presenter = FeedPresenter(view: view,
                                      interactor: interactor,
                                      router: router)
        interactor.output = presenter
        view.output = presenter
        lottieUnknownError.delegate = view
        router.viewController = view
        return view
    }
}
