//  Created by илья on 31.07.23.

import Alamofire
import Foundation

protocol FeedNetworkServiceProtocol {
    func getArticles(source: SourceModel, articlesCount: Int, completion: @escaping GetArticlesResponse)
}

enum ArticleResponseErrors: Error {
    case noInternet
}

typealias GetArticlesResponse = (Result<Data, ArticleResponseErrors>) -> Void

final class FeedNetworkService: FeedNetworkServiceProtocol {
    private enum NetworkConstants: String {
        case everything = "https://newsapi.org/v2/everything"
        case apiKey = "bc613432d94c448da6d678dad9c8806e"
        case reservApiKey = "134f24f4624347d4964bfdbb07479eac"
    }

    func getArticles(source: SourceModel, articlesCount: Int, completion: @escaping GetArticlesResponse) {
        let queryItems = [
            URLQueryItem(name: "domains", value: source.id),
            URLQueryItem(name: "pageSize", value: articlesCount.description),
            URLQueryItem(name: "apiKey", value: NetworkConstants.reservApiKey.rawValue)
        ]
        AF.request(URL(string: NetworkConstants.everything.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
            switch response.result {
            case .success:
                guard let data = response.data else { return }
                DispatchQueue.main.async {
                    debugPrint(response)
                    completion(.success(data))
                }
            case .failure:
                completion(.failure(.noInternet))
            }
        }
    }
}
