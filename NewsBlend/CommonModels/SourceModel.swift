//  Created by илья on 12.08.23.

import Foundation

struct SourceModel: Equatable, Encodable, Decodable {
    let id: String
    let name: String
    var isSelected: Bool
}
