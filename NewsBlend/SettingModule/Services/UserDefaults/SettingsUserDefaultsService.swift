//  Created by илья on 12.08.23.

import Foundation

class SettingsUserDefaultsService: SettingsDBServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func getUpdateInterval() -> Int {
        userDefaults.integer(forKey: "updateInterval")
    }

    func setUpdateUnterval(interval pos: Int) {
        userDefaults.set(pos, forKey: "updateInterval")
    }

    func getSources() -> Data {
        userDefaults.data(forKey: "sources") ?? Data()
    }

    func setSource(sources: Data) {
        userDefaults.set(sources, forKey: "sources")
    }

    func saveChangedListSources(sources: Data) {
        userDefaults.set(sources, forKey: "sources")
    }
}
