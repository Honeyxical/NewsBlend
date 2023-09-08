//  Created by илья on 03.08.23.

import Foundation

final class DetailRouter {
    weak var output: DetailRouterOutputProtocol?
}

extension DetailRouter: DetailRouterInputProtocol {}
