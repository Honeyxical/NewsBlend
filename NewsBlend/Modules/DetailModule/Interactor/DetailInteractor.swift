//  Created by илья on 03.08.23.

import Foundation

class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
    let cacheService: DetailCoreDataServiceProtocol

    init(cacheService: DetailCoreDataServiceProtocol) {
        self.cacheService = cacheService
    }
}

extension DetailInteractor: DetailInteractorInputProtocol {
    func loadData() {
        
    }
}
