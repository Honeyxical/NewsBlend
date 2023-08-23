//  Created by илья on 12.08.23.

import Foundation

class ArticleModel: NSObject, NSCoding {
    let source: SourceModel
    let author: String
    let title: String
    let desctiption: String
    let urlToImage: String
    let publishedAt: String
    var timeSincePublication: String // Время с момента публикации
    let content: String
    
    init(source: SourceModel, author: String, title: String, desctiption: String, urlToImage: String, publishedAt: String, timeSincePublication: String, content: String) {
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
        coder.encode(source, forKey: "source")
        coder.encode(author, forKey: "author")
        coder.encode(title, forKey: "title")
        coder.encode(desctiption, forKey: "desctiption")
        coder.encode(urlToImage, forKey: "urlToImage")
        coder.encode(publishedAt, forKey: "publishedAt")
        coder.encode(timeSincePublication, forKey: "timeSincePublication")
        coder.encode(content, forKey: "content")
        
    }
    
    required init?(coder: NSCoder) {
        self.source = coder.decodeObject(forKey: "source") as? SourceModel ?? SourceModel(id: "", name: "", category: "", language: "", country: "", isSelected: false)
        self.author = coder.decodeObject(forKey: "author") as? String ?? ""
        self.title = coder.decodeObject(forKey: "title") as? String ?? ""
        self.desctiption = coder.decodeObject(forKey: "desctiption") as? String ?? ""
        self.urlToImage = coder.decodeObject(forKey: "urlToImage") as? String ?? ""
        self.publishedAt = coder.decodeObject(forKey: "publishedAt") as? String ?? ""
        self.timeSincePublication = coder.decodeObject(forKey: "timeSincePublication") as? String ?? ""
        self.content = coder.decodeObject(forKey: "content") as? String ?? ""
        super.init()
    }
    
    override func isEqual(_ object: Any?) -> Bool {
        if let otherArticle = object as? ArticleModel {
            return source == otherArticle.source &&
            author == otherArticle.author &&
            title == otherArticle.title &&
            desctiption == otherArticle.desctiption &&
            content == otherArticle.content
        }
        return false
    }
}
