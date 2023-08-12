//  Created by илья on 12.08.23.

import Foundation
import UIKit

class SourceCell: UICollectionViewCell {
    private let sourceName: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name: "HoeflerText-Italic", size: 16)
        label.textAlignment = .center
        label.numberOfLines = 2
        return label
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setSourceName(name: String) {
        self.sourceName.text = name
    }

    private func setupLayout() {
        addSubview(sourceName)

        layer.borderWidth = 1
        layer.borderColor = UIColor.link.cgColor
        layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            sourceName.centerYAnchor.constraint(equalTo: centerYAnchor),
            sourceName.centerXAnchor.constraint(equalTo: centerXAnchor),
            sourceName.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            sourceName.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -5)
        ])
    }
}
