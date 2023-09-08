//  Created by илья on 01.08.23.

import Foundation

class SettingsRouter {
    weak var output: SettingsRouterOutputProtocol?
}

extension SettingsRouter: SettingsRouterInputProtocol {}
