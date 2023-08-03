//  Created by илья on 03.08.23.

import Foundation

class DetailInteractor {
    var output: DetailInteractorOutputProtocol?
    let detailDataService: DetailCoreDataServiceProtocol

    init(detailDataService: DetailCoreDataServiceProtocol) {
        self.detailDataService = detailDataService
    }
}

extension DetailInteractor: DetailInteractorInputProtocol {
    func loadData() {
        
    }
}
