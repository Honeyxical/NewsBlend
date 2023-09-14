//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let newsSettingsViewController = NewsSettingViewController(loader: Loader())
        let view = SettingsViewController()
        let interactor = SettingsInteractor(cacheService: Storage.shared,
                                            networkService: SettingNetworkService(),
                                            parser: SettingParser(articleConverter: SettingArticleConverter(), sourceConverter: SettingSourceConverter()),
                                            sourceCoder: SourceCoding(),
                                            articleConverter: SettingArticleConverter(),
                                            sourceConverter: SettingSourceConverter())
        let router = SettingsRouter()
        let presenter = SettingsPresenter(view: view,
                                          interactor: interactor,
                                          router: router,
                                          newsSettingsProtocol: newsSettingsViewController)

        interactor.output = presenter
        newsSettingsViewController.output = presenter
        newsSettingsViewController.delegate = view
        view.newsSettingView = newsSettingsViewController
        view.output = presenter
        router.output = presenter
        return view
    }
}
