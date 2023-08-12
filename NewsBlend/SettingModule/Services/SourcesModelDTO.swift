//  Created by илья on 09.08.23.

import Foundation

struct SourcesModelDTO: Decodable {
    var sources: [Sources]
}

struct Sources: Decodable {
    let id: String?
    let name: String?
    let category: String?
    let language: String?
    let country: String?

    func map(source: Sources) -> SourceModel {
        SourceModel(id: id ?? "",
                    name: name ?? "",
                    category: category ?? "",
                    language: language ?? "",
                    country: country ?? "")
    }
}
