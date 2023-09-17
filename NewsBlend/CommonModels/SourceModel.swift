//  Created by илья on 12.08.23.

import Foundation

struct SourceModel: Equatable, Encodable, Decodable {
    enum SourceType: Decodable, Encodable{
        case common
        case all
    }

    let id: String
    let name: String
    let type: SourceType
    var isSelected: Bool
}
