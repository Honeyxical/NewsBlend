//  Created by илья on 08.08.23.

import Alamofire
import Foundation

protocol SettingNetworkServiceProtocol {
    func getSources(sourceLanguage: String, completion: @escaping GetSourcesResponse)
}

enum SourceResponseErrors: Error {
    case noInternet
}

typealias GetSourcesResponse = (Result<Data, SourceResponseErrors>) -> Void

final class SettingNetworkService: SettingNetworkServiceProtocol {
    private enum SettingsConstants: String {
        case sources = "https://newsapi.org/v2/top-headlines/sources"
        case apiKey = "bc613432d94c448da6d678dad9c8806e"
        case reserveApiKey = "134f24f4624347d4964bfdbb07479eac"
    }

    func getSources(sourceLanguage: String, completion: @escaping GetSourcesResponse) {
        let queryItems = [
            URLQueryItem(name: "apiKey", value: SettingsConstants.apiKey.rawValue),
            URLQueryItem(name: "language", value: sourceLanguage)
        ]
        AF.request(URL(string: SettingsConstants.sources.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            case .failure:
                completion(.failure(.noInternet))
            }
        }
    }
}
