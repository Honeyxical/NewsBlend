//  Created by илья on 13.08.23.

import Foundation
import UIKit

final class SourcesCell: SourceCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        layer.cornerRadius = 20
        layer.borderColor = UIColor.lightGray.cgColor
    }

    override var isSelected: Bool {
        willSet {
            layer.borderColor = isSelected ? UIColor.systemBlue.cgColor : UIColor.lightGray.cgColor
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func setSourceName(name: String) {
        super.setSourceName(name: name, isSelected: false)
    }
}
