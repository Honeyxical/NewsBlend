//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedAssembly {
    func build() -> UIViewController {
        let lottieUnknownError = LottieUnknownError()
        let view = FeedViewController(childView: NBSAssembly().build(), lottieChildView: lottieUnknownError, loader: Loader())
        let interactor = FeedInteractor(networkService: FeedNetworkService(),
                                        cacheService: Storage.shared,
                                        articleParser: ArticleParser(articleConverter: ArticleConverter()),
                                        articleCoder: ArticleCoding(),
                                        sourceCoder: SourceCoding(),
                                        initialSource: SourceModel(id: "abc-news",
                                                                   name: "ABC News",
                                                                   type: .common,
                                                                   isSelected: true),
                                        defaultSourceHotNews: SourceModel(id: "techcrunch.com",
                                                                          name: "TechCrunch",
                                                                          type: .common,
                                                                          isSelected: false))
        let router = FeedRouter()
        let presenter = FeedPresenter(view: view,
                                      interactor: interactor,
                                      router: router,
                                      articlesPreparation: ArticlesPreparations())
        interactor.output = presenter
        view.output = presenter
        lottieUnknownError.delegate = view
        router.viewController = view
        return view
    }
}
