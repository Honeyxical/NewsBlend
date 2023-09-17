//  Created by илья on 30.07.23.

import Foundation

struct NewsModelDTO: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let author: String?
    let title: String?
    let urlToImage: String?
    let publishedAt: String?
    let content: String?

    func map(article: Article) -> ArticleModel {
        ArticleModel(author: author,
                     title: title,
                     description: content,
                     urlToImage: urlToImage ?? "",
                     publishedAt: publishedAt,
                     timeSincePublication: "")
    }
}
