//  Created by илья on 13.08.23.

import Alamofire
import Foundation

class NBSNetworService: NBSNetworkServiceProtocol {
    private let APIKey = "71ecb82f10374ce28448c08a38e5afda"

    func getArticlesBySource(source: SourceModel, completion: @escaping (Data) -> Void) {
        AF.request("https://newsapi.org/v2/top-headlines?sources=\(source.id)&apiKey=" + APIKey).response { response in
            guard let data = response.data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
