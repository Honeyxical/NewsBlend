//  Created by илья on 31.07.23.

import Alamofire
import Foundation

class FeedNetworkService: FeedNetworkServiceProtocol {
    private var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/everything"
        components.queryItems = [
            URLQueryItem(name: "apiKey", value: "71ecb82f10374ce28448c08a38e5afda"),
            URLQueryItem(name: "domains", value: "techcrunch.com"),
            URLQueryItem(name: "pageSize", value: "5")
        ]
        return components
    }()
    
    func getArticles(completion: @escaping(Data) -> Void) {
        AF.request(urlComponents.url ?? "").response { response in
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
