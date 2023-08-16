//  Created by илья on 31.07.23.

import Foundation

class FeedCoreDataService: FeedCoreDataServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func getSource() -> Data {
        guard let data = userDefaults.data(forKey: "sources") else { return Data() }
        return data
    }

    func setSource(data: Data) {
        userDefaults.set(data, forKey: "sources")
    }
}
