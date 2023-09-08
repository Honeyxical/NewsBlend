//  Created by илья on 31.07.23.

import Alamofire
import Foundation

protocol FeedNetworkServiceProtocol {
    func getArticles(source: SourceModel, articlesCount: Int, completion: @escaping(Data) -> Void)
}

enum FeedPaths: String {
    case everything = "https://newsapi.org/v2/everything"
}

final class FeedNetworkService: FeedNetworkServiceProtocol {
    private let apiKey = "bc613432d94c448da6d678dad9c8806e"

    func getArticles(source: SourceModel, articlesCount: Int, completion: @escaping(Data) -> Void) {
        let queryItems = [
            URLQueryItem(name: "domains", value: source.id),
            URLQueryItem(name: "pageSize", value: articlesCount.description),
            URLQueryItem(name: "apiKey", value: apiKey)
        ]
        AF.request(URL(string: FeedPaths.everything.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in

            switch response.result {
            case .success:
                guard let data = response.data else { return }
                DispatchQueue.main.async {
                    completion(data)
                }
            case .failure:
                completion(Data())
            }
        }
    }
}
