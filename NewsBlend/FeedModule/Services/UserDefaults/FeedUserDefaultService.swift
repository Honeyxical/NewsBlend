//  Created by илья on 31.07.23.

import Foundation

class FeedUserDefaultsService: FeedCoreDataServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func getInterval() -> Int {
        userDefaults.integer(forKey: "updateInterval")
    }

    func setInterval(interval: Int) {
        userDefaults.set(interval, forKey: "updateInterval")
    }

    func getSource() -> Data {
        guard let data = userDefaults.data(forKey: "sources") else { return Data() }
        return data
    }

    func setSource(data: Data) {
        userDefaults.set(data, forKey: "sources")
    }

    func getInitValue() -> Bool {
        userDefaults.bool(forKey: "isInitNeeded")
    }

    func setInitValue(initValue: Bool) {
        userDefaults.set(initValue, forKey: "isInitNeeded")
    }
}
