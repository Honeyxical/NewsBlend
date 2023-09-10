//  Created by илья on 12.08.23.

import Foundation
import UIKit

class SourceCell: UICollectionViewCell {
    private let indicatorIV: UIImageView = {
        let indicator = UIImageView()
        indicator.translatesAutoresizingMaskIntoConstraints = false
        indicator.tintColor = .systemBlue
        return indicator
    }()

    private let sourceNameLabel: UILabel = {
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
    
    func setSourceName(name: String, isSelected: Bool) {
        self.sourceNameLabel.text = name
        self.indicatorIV.image = isSelected == false ? UIImage() : UIImage(systemName: "circle.fill")
    }

    private func setupLayout() {
        addSubview(sourceNameLabel)
        addSubview(indicatorIV)

        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            indicatorIV.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            indicatorIV.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            indicatorIV.heightAnchor.constraint(equalToConstant: 10),
            indicatorIV.widthAnchor.constraint(equalToConstant: 10),

            sourceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sourceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sourceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sourceNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
