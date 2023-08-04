//  Created by илья on 01.08.23.

import Foundation
import UIKit

final class FeedRouter {
    weak var viewController: UIViewController?
}

extension FeedRouter: FeedRouterInputProtocol {
    func openArticleDetail(article: Article) {
        let detailViewController = DetailAssembly.build(artile: article)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
