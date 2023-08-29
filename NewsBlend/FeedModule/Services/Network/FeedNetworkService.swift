//  Created by илья on 31.07.23.

import Alamofire
import Foundation

enum Paths: String {
    case everything = "/v2/everything"
}

class FeedNetworkService: FeedNetworkServiceProtocol {
    private lazy var everything: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = Paths.everything.rawValue
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e")
        ]
        return components
    }()

    func getArticles(queryItems: [URLQueryItem], completion: @escaping(Data) -> Void) {
        everything.queryItems! += queryItems
        AF.request(everything.url ?? "").response { response in
            debugPrint(response)
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
