//  Created by илья on 08.08.23.

import Alamofire
import Foundation

protocol SettingNetworkServiceProtocol {
    func getSources(sourceLanguage: String, success: @escaping (Data) -> Void, failure: @escaping () -> Void)
}

enum SettingsPaths: String {
    case sources = "https://newsapi.org/v2/top-headlines/sources"
}

final class SettingNetworkService: SettingNetworkServiceProtocol {
    private let apiKey = "bc613432d94c448da6d678dad9c8806e"

    func getSources(sourceLanguage: String, success: @escaping (Data) -> Void, failure: @escaping () -> Void) {
        let queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "language", value: sourceLanguage)
        ]
        AF.request(URL(string: SettingsPaths.sources.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                DispatchQueue.main.async {
                    success(data)
                }
            case .failure:
                failure()
            }
        }
    }
}
