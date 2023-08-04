//  Created by илья on 03.08.23.

import Foundation

class DetailRouter {
    var output: DetailRouterOutputProtocol?
    var feedRouter: FeedRouterInputProtocol?
}

extension DetailRouter: DetailRouterInputProtocol{
    func openArticle(article: Article) {
    }
}
