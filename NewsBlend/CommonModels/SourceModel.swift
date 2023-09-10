//  Created by илья on 12.08.23.

import Foundation

struct SourceModel: Equatable, Encodable, Decodable {
    var id: String
    var name: String
    var category: String
    var language: String
    var country: String
    var isSelected: Bool
}
