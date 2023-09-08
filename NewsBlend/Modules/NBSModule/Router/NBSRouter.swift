//  Created by илья on 13.08.23.

import UIKit

class NBSRouter {
    weak var output: NBSRouterOutputProtocol?
    weak var viewController: UIViewController?
}

extension NBSRouter: NBSRouterInputProtocol {
    func openArticleDetail(article: ArticleModel, controller: UIViewController) {
        let detailViewController = DetailAssembly.build(artile: article)
        controller.navigationController?.pushViewController(detailViewController, animated: true)
    }
}
