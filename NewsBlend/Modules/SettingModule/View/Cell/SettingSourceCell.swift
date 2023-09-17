//  Created by илья on 12.08.23.

import UIKit

class SettingSourceCell: UICollectionViewCell {
    private let indicatorImageView: UIImageView = {
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

    override func prepareForReuse() {
        super.prepareForReuse()
        sourceNameLabel.text = nil
    }
    
    func setSourceName(name: String, isSelected: Bool) {
        self.sourceNameLabel.text = name
        self.indicatorImageView.image = isSelected == false ? UIImage() : UIImage(systemName: "circle.fill")
    }

    private func setupLayout() {
        addSubview(sourceNameLabel)
        addSubview(indicatorImageView)

        layer.borderWidth = 1
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 10

        NSLayoutConstraint.activate([
            indicatorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 5),
            indicatorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 5),
            indicatorImageView.heightAnchor.constraint(equalToConstant: 10),
            indicatorImageView.widthAnchor.constraint(equalToConstant: 10),

            sourceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sourceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sourceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            sourceNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        ])
    }
}
