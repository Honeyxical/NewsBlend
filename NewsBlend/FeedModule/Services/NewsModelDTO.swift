//  Created by илья on 30.07.23.

import Foundation

struct NewsModelDTO: Decodable {
    let articles: [Article]
}

struct Article: Decodable {
    let source: Source?
    let author: String?
    let title: String?
    let description: String?
    let urlToImage: String?
    var publishedAt: String?
    let content: String?

    func map(article: Article) -> ArticleModel {
        ArticleModel(
            source: source ?? Source(id: "", name: ""),
            author: author ?? "",
            title: title ?? "",
            desctiption: description ?? "",
            urlToImage: urlToImage ?? "",
            publishedAt: publishedAt ?? "",
            timeSincePublication: "",
            content: content ?? "")
    }
}

struct Source: Decodable {
    let id: String?
    let name: String?
}
