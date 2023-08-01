//  Created by илья on 30.07.23.

import Foundation

struct NewsModel: Decodable {
    let articles: [Articles]
}

struct Articles: Decodable {
    let author: String
    let title: String
    let description: String
    let urlToImage: String
}
