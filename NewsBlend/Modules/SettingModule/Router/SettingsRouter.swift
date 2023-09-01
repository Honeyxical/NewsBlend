//  Created by илья on 01.08.23.

import Foundation

class SettingsRouter {
    var output: SettingsRouterOutputProtocol?
    var feedRouter: FeedRouterInputProtocol?

}

extension SettingsRouter: SettingsRouterInputProtocol {
    
}
