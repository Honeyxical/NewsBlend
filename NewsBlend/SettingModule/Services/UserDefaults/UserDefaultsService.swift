//  Created by илья on 12.08.23.

import Foundation

class UserDefaultsService: SettingsDBServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func getUpdateInterval() -> Int {
        userDefaults.integer(forKey: "updateInterval")
    }

    func setUpdateUnterval(interval pos: Int) {
        userDefaults.set(pos, forKey: "updateInterval")
    }

    func getSources() -> [Sources] {
        []
    }

    func setSource(source: Source) {
    }

}
