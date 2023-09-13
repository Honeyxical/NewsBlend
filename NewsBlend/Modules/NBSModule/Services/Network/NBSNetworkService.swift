//  Created by илья on 13.08.23.

import Alamofire
import Foundation

protocol NBSNetworkServiceProtocol {
    func getArticlesBySource(source: SourceModel, pageSize: Int, completion: @escaping GetNBSArticlesResponse)
}

enum NBSArticlesResponseErrors: Error {
    case noInternet
}

typealias GetNBSArticlesResponse = (Result<Data, NBSArticlesResponseErrors>) -> Void

final class NBSNetworkService: NBSNetworkServiceProtocol {
    private enum NBSConstants: String {
        case topHeadlines = "https://newsapi.org/v2/top-headlines/"
        case apiKey = "bc613432d94c448da6d678dad9c8806e"
        case reserveApiKey = "134f24f4624347d4964bfdbb07479eac"
    }

    func getArticlesBySource(source: SourceModel, pageSize: Int, completion: @escaping GetNBSArticlesResponse) {
        let queryItems = [
            URLQueryItem(name: "apiKey", value: NBSConstants.apiKey.rawValue),
            URLQueryItem(name: "pageSize", value: pageSize.description),
            URLQueryItem(name: "sources", value: source.id)
        ]
        AF.request(URL(string: NBSConstants.topHeadlines.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
            guard let data = response.data else {
                completion(.failure(.noInternet))
                return
            }
            DispatchQueue.main.async {
                completion(.success(data))
            }
        }
    }
}
