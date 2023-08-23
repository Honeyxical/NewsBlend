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
            source: SourceModel(id: source?.id ?? "",
                                name: source?.name ?? "",
                                category: "",
                                language: "",
                                country: "",
                                isSelected: false),
            author: author ?? "",
            title: title ?? "",
            desctiption: description ?? "",
            urlToImage: urlToImage ?? "",
            publishedAt: publishedAt ?? "",
            timeSincePublication: "",
            content: content ?? "")
    }
}

struct Source: Decodable, Equatable {
    let id: String?
    let name: String?
    
    static func == (lhs: Source, rhs: Source) -> Bool {
        lhs.id == rhs.id && lhs.name == rhs.name
    }
}
