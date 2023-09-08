//  Created by илья on 03.08.23.

import Foundation

final class DetailInteractor {
    weak var output: DetailInteractorOutputProtocol?
    let cacheService: DetailCoreDataServiceProtocol

    init(cacheService: DetailCoreDataServiceProtocol) {
        self.cacheService = cacheService
    }
}

extension DetailInteractor: DetailInteractorInputProtocol {}
