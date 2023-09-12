//  Created by илья on 13.08.23.

import Foundation

protocol NBSStorageProtocol{
    func getSources() -> Data
    func setArticles(data: Data, source: String)
    func getArticles(source: String) -> Data
}

final class NBSUserDefaultsService: NBSStorageProtocol {
    private let userDefaults = UserDefaults.standard

    func getSources() -> Data {
        guard let data = userDefaults.data(forKey: "sources") else {
            return Data()
        }
        return data
    }
    
    func setArticles(data: Data, source: String) {
        userDefaults.set(data, forKey: source)
    }
    
    func getArticles(source: String) -> Data {
        guard let articles = userDefaults.data(forKey: source) else { return Data() }
        return articles
    }
}
