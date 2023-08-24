//  Created by илья on 13.08.23.

import Alamofire
import Foundation

class NBSNetworService: NBSNetworkServiceProtocol {
    private var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines/"
        components.queryItems = [
//            URLQueryItem(name: "apiKey", value: "71ecb82f10374ce28448c08a38e5afda"),
            URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e"),
            URLQueryItem(name: "pageSize", value: "10")
        ]
        return components
    }()

    func getArticlesBySource(source: SourceModel, completion: @escaping (Data) -> Void) {
        urlComponents.queryItems?.append(URLQueryItem(name: "sources", value: source.id))
        AF.request(urlComponents.url ?? "").response { response in
            self.urlComponents.queryItems?.removeLast()
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
