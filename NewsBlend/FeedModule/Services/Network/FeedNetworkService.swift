//  Created by илья on 31.07.23.

import Alamofire
import Foundation

enum Paths: String {
    case everything = "https://newsapi.org/v2/everything"
}

class FeedNetworkService: FeedNetworkServiceProtocol {
    func getArticles(queryItems: [URLQueryItem], completion: @escaping(Data) -> Void) {
        AF.request(URL(string: Paths.everything.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
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
