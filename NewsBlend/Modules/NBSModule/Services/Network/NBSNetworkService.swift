//  Created by илья on 13.08.23.

import Alamofire
import Foundation

protocol NBSNetworkServiceProtocol {
    func getArticlesBySource(source: SourceModel, pageSize: Int, completion: @escaping GetNBSArticlesResponse)
}

enum NBSArticlesResponceErrors: Error {
    case noInternet
    case failedToGetData
}

typealias GetNBSArticlesResponse = (Result<Data, NBSArticlesResponceErrors>) -> Void

final class NBSNetworService: NBSNetworkServiceProtocol {
    private enum NBSConstants: String {
        case topHeadlines = "https://newsapi.org/v2/top-headlines/"
        case apiKey = "bc613432d94c448da6d678dad9c8806e"
    }

    func getArticlesBySource(source: SourceModel, pageSize: Int, completion: @escaping GetNBSArticlesResponse) {
        let queryItems = [
            URLQueryItem(name: "apiKey", value: NBSConstants.apiKey.rawValue),
            URLQueryItem(name: "pageSize", value: pageSize.description),
            URLQueryItem(name: "sources", value: source.id)
        ]
        AF.request(URL(string: NBSConstants.topHeadlines.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
            switch response.result {
            case .success:
                guard let data = response.data else {
                    completion(.failure(.failedToGetData))
                    return
                }
                DispatchQueue.main.async {
                    completion(.success(data))
                }
            case .failure:
                completion(.failure(.noInternet))
            }
        }
    }
}
