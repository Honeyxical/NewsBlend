//  Created by илья on 12.08.23.

import Foundation

class SourceModel: NSObject {
    var id: String
    var name: String
    var category: String
    var language: String
    var country: String
    var isSelected: Bool

    init(id: String,
         name: String,
         category: String,
         language: String,
         country: String,
         isSelected: Bool) {
        self.id = id
        self.name = name
        self.category = category
        self.language = language
        self.country = country
        self.isSelected = isSelected
    }

    required init?(coder: NSCoder) {
        self.id = coder.decodeObject(forKey: "id") as? String ?? ""
        self.name = coder.decodeObject(forKey: "name") as? String ?? ""
        self.category = coder.decodeObject(forKey: "category") as? String ?? ""
        self.language = coder.decodeObject(forKey: "language") as? String ?? ""
        self.country = coder.decodeObject(forKey: "country") as? String ?? ""
        self.isSelected = coder.decodeBool(forKey: "isSelected")
    }
}

extension SourceModel: NSCoding {
    func encode(with coder: NSCoder) {
        coder.encode(id, forKey: "id")
        coder.encode(name, forKey: "name")
        coder.encode(category, forKey: "category")
        coder.encode(language, forKey: "language")
        coder.encode(country, forKey: "country")
        coder.encode(isSelected, forKey: "isSelected")
    }
}
