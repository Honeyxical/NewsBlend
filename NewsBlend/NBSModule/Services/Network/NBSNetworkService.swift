//  Created by илья on 13.08.23.

import Alamofire
import Foundation

enum NBSPaths: String {
    case topHeadlines = "https://newsapi.org/v2/top-headlines/"
}

class NBSNetworService: NBSNetworkServiceProtocol {
    func getArticlesBySource(queryItems: [URLQueryItem], completion: @escaping (Data) -> Void) {
        AF.request(URL(string: NBSPaths.topHeadlines.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
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
