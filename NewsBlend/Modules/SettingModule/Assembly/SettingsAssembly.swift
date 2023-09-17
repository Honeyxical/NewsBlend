//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    func build() -> UIViewController {
        let newsSettingsViewController = NewsSettingViewController(loader: Loader())
        let interactor = SettingsInteractor(cacheService: Storage.shared,
                                            networkService: SettingNetworkService(),
                                            sourceParser: SourceParser(sourceConverter: SourceConverter()),
                                            sourceCoder: SourceCoding())
        let router = SettingsRouter()
        let presenter = SettingsPresenter(view: newsSettingsViewController,
                                          interactor: interactor,
                                          router: router)

        interactor.output = presenter
        newsSettingsViewController.output = presenter
        router.output = presenter
        return newsSettingsViewController
    }
}
