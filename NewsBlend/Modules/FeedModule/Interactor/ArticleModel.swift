//  Created by илья on 12.08.23.

import Foundation

struct ArticleModel: Equatable, Encodable, Decodable {
    let source: SourceModel
    let author: String
    let title: String
    let desctiption: String
    let urlToImage: String
    let publishedAt: String
    var timeSincePublication: String // Время с момента публикации
    let content: String
}
