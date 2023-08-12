//  Created by илья on 31.07.23.

import Alamofire
import Foundation

class FeedNetworkService: FeedNetworkServiceProtocol {
    private let APIKey = "71ecb82f10374ce28448c08a38e5afda"

    func getHotNews(country: String, completion: @escaping (Data) -> Void) {
        AF.request("https://newsapi.org/v2/top-headlines?country=\(country)&pageSize=3&apiKey=\(APIKey)").response { response in
            guard let data = response.data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }

    func getNews(completion: @escaping(Data) -> Void) {
        AF.request("https://newsapi.org/v2/everything?domains=techcrunch.com&pageSize=10&apiKey=\(APIKey)").response { response in
            guard let data = response.data else { return }
            DispatchQueue.main.async {
                completion(data)
            }
        }
    }
}
