//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let newsSettingsView = NewsSettingView()
        let view = SettingsView()
        let interactor = SettingsInteractor(settingsDataService: SettingsUserDefaultsService(), settingNetworkService: SettingNetworkService())
        let router = SettingsRouter()
        let presentor = SettingsPresentor(view: view,
                                          interactor: interactor,
                                          router: router,
                                          newsSettingsProtocol: newsSettingsView)

        interactor.output = presentor
        newsSettingsView.output = presentor
        view.newsSettingView = newsSettingsView
        view.output = presentor
        router.output = presentor
        router.feedRouter = FeedRouter()
        return view
    }
}
