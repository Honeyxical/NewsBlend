//  Created by илья on 12.08.23.

import Foundation

class UserDefaultsService: SettingsDBServiceProtocol {
    private let userDefaults = UserDefaults.standard

    func getUpdateInterval() -> Int {
        let aaaa = userDefaults.integer(forKey: "updateInterval")
        print(aaaa)
        return aaaa
    }

    func setUpdateUnterval(interval pos: Int) {
        userDefaults.set(pos, forKey: "updateInterval")
    }

    func getSources() -> Data {
        userDefaults.data(forKey: "sources") ?? Data()
    }

    func setSource(source: SourceModel) {
        userDefaults.set(source, forKey: "source")
    }

}
