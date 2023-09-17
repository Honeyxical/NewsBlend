//  Created by илья on 13.08.23.

import UIKit

final class NBSRouter {
    weak var output: NBSRouterOutputProtocol?
    weak var viewController: UIViewController?
}

extension NBSRouter: NBSRouterInputProtocol {
    func openArticleDetail(article: ArticleModel) {
        let detailViewController = DetailAssembly.build(artiсle: article)
        viewController?.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

extension NBSModuleInputProtocol {
//    func needToUpdateSources() {
//    }
}
