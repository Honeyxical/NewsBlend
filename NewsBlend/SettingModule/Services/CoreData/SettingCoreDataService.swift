//  Created by илья on 01.08.23.

import Foundation

final class SettingsCoreDataService: SettingsDBServiceProtocol {
    func getUpdateInterval() -> Int {
        0
    }
    
    func setUpdateUnterval(interval pos: Int) {
    }
    
    func getSources() -> Data {
        Data()
    }
    
    func setSource(sources source: Data) {

    }
}
