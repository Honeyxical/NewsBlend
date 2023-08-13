//  Created by илья on 13.08.23.

import Foundation

class NBSUserDefaultsService: NBSDataServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func getSources() -> Data {
        guard let data = userDefaults.data(forKey: "sources") else {
            return Data()
        }
        return data
    }
}
