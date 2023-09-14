//  Created by илья on 31.07.23.

import Alamofire
import Foundation

protocol FeedNetworkServiceProtocol {
    func getArticles(source: SourceModel, articlesCount: Int, completion: @escaping GetArticlesResponse)
}

enum ArticleResponseErrors: Error {
    case noInternet
    case parseFailed
    case errorUrlConfiguring
}

typealias GetArticlesResponse = (Result<Data, ArticleResponseErrors>) -> Void

final class FeedNetworkService: FeedNetworkServiceProtocol {
    private enum NetworkConstants: String {
        case everything = "https://newsapi.org/v2/everything"
        case apiKey = "bc613432d94c448da6d678dad9c8806e"
        case reserveApiKey = "134f24f4624347d4964bfdbb07479eac"
    }

    let reachabilityManager = Alamofire.NetworkReachabilityManager(host: "www.google.com")

    func getArticles(source: SourceModel, articlesCount: Int, completion: @escaping GetArticlesResponse) {
        if let isReachable = reachabilityManager?.isReachable, isReachable {
            let queryItems = [
                URLQueryItem(name: "domains", value: source.id),
                URLQueryItem(name: "pageSize", value: articlesCount.description),
                URLQueryItem(name: "apiKey", value: NetworkConstants.reserveApiKey.rawValue)
            ]

            guard let url = URL(string: NetworkConstants.everything.rawValue)?.appending(queryItems: queryItems) else {
                completion(.failure(.errorUrlConfiguring))
                return
            }

            AF.request(url).response { response in
                guard let data = response.data else {
                    completion(.failure(.parseFailed))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            }
        } else {
            completion(.failure(.noInternet))
        }
    }
}
