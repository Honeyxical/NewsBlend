//  Created by илья on 09.08.23.

import Foundation

struct SourcesModel: Decodable {
    let sources: [Sources]
}

struct Sources: Decodable {
    let id: String
    let name: String
    let category: String
    let language: String
    let country: String
}
