//  Created by илья on 31.07.23.

import Foundation

protocol FeedStorageProtocol{
    func getSource() -> Data
    func setSource(data: Data)
    func getInterval() -> Int
    func setInterval(interval: Int)
    func getInitValue() -> Bool
    func setInitValue(initValue: Bool)
    func setArticles(data: Data)
    func getArticles() -> Data
}

final class FeedUserDefaultsService: FeedStorageProtocol {
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
    
    func setArticles(data: Data) {
        userDefaults.set(data, forKey: "articlesFeed")
    }
    
    func getArticles() -> Data {
        guard let data = userDefaults.data(forKey: "articlesFeed") else { return Data() }
        return data
    }
}
