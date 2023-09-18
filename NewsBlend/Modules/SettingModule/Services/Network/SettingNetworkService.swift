//  Created by илья on 08.08.23.

import Alamofire
import Foundation

protocol SettingNetworkServiceProtocol {
    func getSources(sourceLanguage: String, completion: @escaping GetSourcesResponse)
}

enum SettingsResponseErrors: Error {
    case noInternet
    case errorParsingData
}

typealias GetSourcesResponse = (Result<Data, SettingsResponseErrors>) -> Void

final class SettingNetworkService: SettingNetworkServiceProtocol {
    private enum SettingsConstants: String {
        case sources = "https://newsapi.org/v2/top-headlines/sources"
        case apiKey = "bc613432d94c448da6d678dad9c8806e"
        case reserveApiKey = "134f24f4624347d4964bfdbb07479eac"
    }

    let reachabilityManager = NetworkReachabilityManager(host: "www.google.com")

    func getSources(sourceLanguage: String, completion: @escaping GetSourcesResponse) {
        if let isReachable = reachabilityManager?.isReachable, isReachable {
            let queryItems = [
                URLQueryItem(name: "apiKey", value: SettingsConstants.apiKey.rawValue),
                URLQueryItem(name: "language", value: sourceLanguage)
            ]

            guard let url = URL(string: SettingsConstants.sources.rawValue)?.appending(queryItems: queryItems) else {
                return
            }

            AF.request(url).response { response in
                guard let data = response.data else {
                    DispatchQueue.main.async {
                        completion(.failure(.errorParsingData))
                    }
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        } else {
            DispatchQueue.main.async {
                completion(.failure(.noInternet))
            }
        }
    }
}
