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
    
    func setArtcles(data: Data, source: String) {
        userDefaults.set(data, forKey: source)
    }
    
    func getArticles(source: String) -> Data {
        guard let articles = userDefaults.data(forKey: source) else { return Data() }
        return articles
    }
}
