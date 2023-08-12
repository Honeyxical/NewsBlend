//  Created by илья on 12.08.23.

import Foundation

class ArticleModel: NSObject, NSCoding {
    let source: Source
    let author: String
    let title: String
    let desctiption: String
    let urlToImage: String
    let publishedAt: String
    var timeSincePublication: String // Время с момента публикации
    let content: String

    init(source: Source, author: String, title: String, desctiption: String, urlToImage: String, publishedAt: String, timeSincePublication: String, content: String) {
        self.source = source
        self.author = author
        self.title = title
        self.desctiption = desctiption
        self.urlToImage = urlToImage
        self.publishedAt = publishedAt
        self.timeSincePublication = timeSincePublication
        self.content = content
        super.init()
    }

    func encode(with coder: NSCoder) {
    }

    required init?(coder: NSCoder) {
        self.source = Source(id: "", name: "")
        self.author = ""
        self.title = "title"
        self.desctiption = "desctiption"
        self.urlToImage = "urlToImage"
        self.publishedAt = "publishedAt"
        self.timeSincePublication = "timeSincePublication"
        self.content = "content"
        super.init()
    }

}
