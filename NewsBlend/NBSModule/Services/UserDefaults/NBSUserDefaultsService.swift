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
    
    func setArtcles(data: Data) {
        userDefaults.set(data, forKey: "articlesNBS")
    }
    
    func getArticles() -> Data {
        guard let articles = userDefaults.data(forKey: "articlesNBS") else { return Data() }
        return articles
    }
    
    func setArticlesByAllSource(data: Data) {
        userDefaults.set(data, forKey: "articleByAllSourceNBS")
    }
    
    func getArticlesByAllSource() -> Data {
        guard let articles = userDefaults.data(forKey: "articleByAllSourceNBS") else { return Data() }
        return articles
    }
}
