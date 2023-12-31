//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedRouter {
    weak var viewController: UIViewController?
}

extension FeedRouter: FeedRouterInputProtocol {
    func openSettings() {
        let settingsViewController = SettingsAssembly().build()
        viewController?.navigationController?.pushViewController(settingsViewController, animated: true)
    }

    func openArticleDetail(article: PresenterModel) {
        let detailViewController = DetailAssembly().build(artiсle: article)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
