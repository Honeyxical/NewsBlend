//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let newsSettingsViewController = NewsSettingViewController()
        let view = SettingsViewController()
        let interactor = SettingsInteractor(cacheService: SettingsUserDefaultsService(),
                                            networkService: SettingNetworkService(),
                                            parser: Parser())
        let router = SettingsRouter()
        let presentor = SettingsPresentor(view: view,
                                          interactor: interactor,
                                          router: router,
                                          newsSettingsProtocol: newsSettingsViewController)

        interactor.output = presentor
        newsSettingsViewController.output = presentor
        view.newsSettingView = newsSettingsViewController
        view.output = presentor
        router.output = presentor
        return view
    }
}
