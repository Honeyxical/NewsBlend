//  Created by илья on 08.08.23.

import Alamofire
import Foundation

class SettingNetworkService: SettingNetworkServiceProtocol {
    let APIKey = "71ecb82f10374ce28448c08a38e5afda"

    func getEngSources(completion: @escaping (Data) -> Void) {
        AF.request("https://newsapi.org/v2/top-headlines/sources?language=en&apiKey=" + APIKey).response { response in
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
