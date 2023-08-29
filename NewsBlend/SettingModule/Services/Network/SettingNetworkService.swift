//  Created by илья on 08.08.23.

import Alamofire
import Foundation

enum SettingsPaths: String {
    case sources = "https://newsapi.org/v2/top-headlines/sources"
}

class SettingNetworkService: SettingNetworkServiceProtocol {
    func getSources(queryItems: [URLQueryItem], completion: @escaping (Data) -> Void) {
        AF.request(URL(string: SettingsPaths.sources.rawValue)?.appending(queryItems: queryItems) ?? "").response { response in
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
