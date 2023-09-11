//  Created by илья on 12.08.23.

import Foundation

struct ArticleModel: Equatable, Encodable, Decodable {
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String
    let publishedAt: String?
    /// The variable "timeSincePublication" stores the time since publication
    var timeSincePublication: String
}
