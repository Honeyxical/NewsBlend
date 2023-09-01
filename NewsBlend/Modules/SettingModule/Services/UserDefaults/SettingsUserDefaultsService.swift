//  Created by илья on 12.08.23.

import Foundation

protocol SettingStorageProtocol{
    func getUpdateInterval() -> Int
    func setUpdateUnterval(interval pos: Int)
    func getSources() -> Data
    func setSource(sources: Data)
    func saveChangedListSources(sources: Data)
}

class SettingsUserDefaultsService: SettingStorageProtocol {
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
