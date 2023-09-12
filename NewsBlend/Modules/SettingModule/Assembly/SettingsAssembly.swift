//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let newsSettingsViewController = NewsSettingViewController()
        let view = SettingsViewController()
        let interactor = SettingsInteractor(cacheService: Storage.shared,
                                            networkService: SettingNetworkService(),
                                            parser: SettingParser(converter: SettingConverter()),
                                            converter: SettingConverter(),
                                            sourceCoder: SourceCoding())
        let router = SettingsRouter()
        let presenter = SettingsPresenter(view: view,
                                          interactor: interactor,
                                          router: router,
                                          newsSettingsProtocol: newsSettingsViewController)

        interactor.output = presenter
        newsSettingsViewController.output = presenter
        view.newsSettingView = newsSettingsViewController
        view.output = presenter
        router.output = presenter
        return view
    }
}
