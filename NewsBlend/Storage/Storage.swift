//  Created by илья on 12.09.23.

import Foundation

protocol SettingStorageProtocol{
    func getUpdateInterval() -> Int
    func setUpdateInterval(interval pos: UpdateIntervals)
    func getSources() -> Data
    func setSource(sources: Data)
    func saveChangedListSources(sources: Data)
    func deleteSourceArticles(sourceId: String)
}

protocol NBSStorageProtocol{
    func getSources() -> Data
    func setArticles(data: Data, source: String)
    func getArticles(source: String) -> Data
    func getUpdateInterval() -> Int
}

protocol FeedStorageProtocol{
    func getSource() -> Data
    func setSource(data: Data)
    func getInterval() -> Int
    func setInterval(interval: UpdateIntervals)
    func getInitValue() -> Bool
    func setInitValue(initValue: Bool)
    func setArticles(data: Data)
    func getArticles() -> Data
}

final class Storage {
    enum Constants {
        static let updateInterval = "updateInterval"
        static let sources = "sources"
        static let isInitNeeded = "isInitNeeded"
        static let articlesFeed = "articlesFeed"
    }

    static let shared = Storage()
    private let userDefaults = UserDefaults.standard
}

extension Storage: SettingStorageProtocol {
    func deleteSourceArticles(sourceId: String) {
        userDefaults.removeObject(forKey: sourceId)
    }

    func getUpdateInterval() -> Int {
        userDefaults.integer(forKey: Constants.updateInterval)
    }

    func setUpdateInterval(interval pos: UpdateIntervals) {
        userDefaults.set(pos.rawValue, forKey: Constants.updateInterval)
    }

    func getSources() -> Data {
        userDefaults.data(forKey: Constants.sources) ?? Data()
    }

    func setSource(sources: Data) {
        userDefaults.set(sources, forKey: Constants.sources)
    }

    func saveChangedListSources(sources: Data) {
        userDefaults.set(sources, forKey: Constants.sources)
    }
}

extension Storage: NBSStorageProtocol {
    func setArticles(data: Data, source: String) {
        let data = data
        let source = source
        userDefaults.set(data, forKey: source)
    }

    func getArticles(source: String) -> Data {
        guard let articles = userDefaults.data(forKey: source) else { return Data() }
        return articles
    }
}

extension Storage: FeedStorageProtocol {
    func getInterval() -> Int {
        userDefaults.integer(forKey: Constants.updateInterval)
    }

    func setInterval(interval: UpdateIntervals) {
        userDefaults.set(interval, forKey: Constants.updateInterval)
    }

    func getSource() -> Data {
        guard let data = userDefaults.data(forKey: Constants.sources) else { return Data() }
        return data
    }

    func setSource(data: Data) {
        userDefaults.set(data, forKey: Constants.sources)
    }

    func getInitValue() -> Bool {
        userDefaults.bool(forKey: Constants.isInitNeeded)
    }

    func setInitValue(initValue: Bool) {
        userDefaults.set(initValue, forKey: Constants.isInitNeeded)
    }

    func setArticles(data: Data) {
        userDefaults.set(data, forKey: Constants.articlesFeed)
    }

    func getArticles() -> Data {
        guard let data = userDefaults.data(forKey: Constants.articlesFeed) else { return Data() }
        return data
    }
}
