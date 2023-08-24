//  Created by илья on 08.08.23.

import Alamofire
import Foundation

class SettingNetworkService: SettingNetworkServiceProtocol {
    private var urlComponents: URLComponents = {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "newsapi.org"
        components.path = "/v2/top-headlines/sources"
        components.queryItems = [
//            URLQueryItem(name: "apiKey", value: "71ecb82f10374ce28448c08a38e5afda"),
            URLQueryItem(name: "apiKey", value: "bc613432d94c448da6d678dad9c8806e"),
            URLQueryItem(name: "language", value: "en")
        ]
        return components
    }()
    
    func getSources(completion: @escaping (Data) -> Void) {
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
