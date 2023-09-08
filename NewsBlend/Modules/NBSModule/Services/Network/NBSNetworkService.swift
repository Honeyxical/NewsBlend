//  Created by илья on 13.08.23.

import Alamofire
import Foundation

protocol NBSNetworkServiceProtocol {
    func getArticlesBySource(source: SourceModel, pageSize: Int, completion: @escaping (Data) -> Void)
}

enum NBSPaths: String {
    case topHeadlines = "https://newsapi.org/v2/top-headlines/"
}

final class NBSNetworService: NBSNetworkServiceProtocol {
    private let apiKey = "bc613432d94c448da6d678dad9c8806e"
    
    func getArticlesBySource(source: SourceModel, pageSize: Int, completion: @escaping (Data) -> Void) {
        let queryItems = [
            URLQueryItem(name: "apiKey", value: apiKey),
            URLQueryItem(name: "pageSize", value: pageSize.description),
            URLQueryItem(name: "sources", value: source.id)
        ]
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
