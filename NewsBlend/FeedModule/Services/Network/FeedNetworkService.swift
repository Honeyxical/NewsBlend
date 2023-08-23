//  Created by илья on 31.07.23.

import Alamofire
import Foundation

class FeedNetworkService: FeedNetworkServiceProtocol {
    private let APIKey = "71ecb82f10374ce28448c08a38e5afda"

    func getNews(completion: @escaping(Data) -> Void) {
        AF.request("https://newsapi.org/v2/everything?domains=techcrunch.com&pageSize=5&apiKey=\(APIKey)").response { response in
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
