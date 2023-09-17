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
        label.font = UIFont(name: "HoeflerText-Italic", size: 16.0)
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
        self.indicatorImageView.image = !isSelected ? UIImage() : UIImage(systemName: "circle.fill")
    }

    private func setupLayout() {
        addSubview(sourceNameLabel)
        addSubview(indicatorImageView)

        layer.borderWidth = 1.0
        layer.borderColor = UIColor.systemBlue.cgColor
        layer.cornerRadius = 12.0

        NSLayoutConstraint.activate([
            indicatorImageView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 4.0),
            indicatorImageView.topAnchor.constraint(equalTo: topAnchor, constant: 4.0),
            indicatorImageView.heightAnchor.constraint(equalToConstant: 12.0),
            indicatorImageView.widthAnchor.constraint(equalToConstant: 12.0),

            sourceNameLabel.centerYAnchor.constraint(equalTo: centerYAnchor),
            sourceNameLabel.centerXAnchor.constraint(equalTo: centerXAnchor),
            sourceNameLabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 12.0),
            sourceNameLabel.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -12.0)
        ])
    }
}
