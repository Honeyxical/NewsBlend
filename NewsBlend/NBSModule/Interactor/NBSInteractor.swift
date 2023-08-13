//  Created by илья on 13.08.23.

import Foundation

class NBSInteractor {
    var output: NBSInteractorOutputProtocol?
    let networkService: NBSNetworkServiceProtocol
    let storageService: NBSDataServiceProtocol

    init(networkService: NBSNetworkServiceProtocol, storageService: NBSDataServiceProtocol) {
        self.networkService = networkService
        self.storageService = storageService
    }
}

extension NBSInteractor: NBSInteractorInputProtocol {
    func loadData() {
        
    }
}
