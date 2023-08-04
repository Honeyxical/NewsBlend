//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class SettingsAssembly {
    static func build() -> UIViewController {
        let view = SettingsView()
        let interactor = SettingsInteractor(settingsDataService: SettingsCoreDataService())
        let router = SettingsRouter()
        let presentor = SettingsPresentor(view: view,
                                          interactor: interactor,
                                          router: router)

        interactor.output = presentor
        view.output = presentor
        router.output = presentor
        router.feedRouter = FeedRouter()
        return view
    }
}
