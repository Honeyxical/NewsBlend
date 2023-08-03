//  Created by илья on 30.07.23.

import Foundation

struct NewsModel: Decodable {
    let articles: [Articles]
}

struct Articles: Decodable {
    let source: Source
    let author: String?
    let title: String
    let description: String
    let urlToImage: String
    var publishedAt: String
}

struct Source: Decodable {
    let id: String?
    let name: String
}
