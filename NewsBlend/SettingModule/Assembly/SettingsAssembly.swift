//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let view = SettingsView()
        let interactor = SettingsInteractor(settingsDataService: SettingsCoreDataService(), settingNetworkService: SettingNetworkService())
        let router = SettingsRouter()
        let newsSettingsView = NewsSettingView()
        let presentor = SettingsPresentor(view: view,
                                          interactor: interactor,
                                          router: router,
                                          newsSettingsProtocol: newsSettingsView)

        interactor.output = presentor
        view.output = presentor
        view.newsSettingView = newsSettingsView
        newsSettingsView.output = presentor
        router.output = presentor
        router.feedRouter = FeedRouter()
        return newsSettingsView
    }
}
