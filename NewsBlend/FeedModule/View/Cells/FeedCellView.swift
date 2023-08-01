//  Created by илья on 01.08.23.

import Foundation
import UIKit

class FeedCellView: UICollectionViewCell {
    private var title: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        return title
    }()

    internal var shortDescription: UILabel = {
        let description = UILabel()
        description.translatesAutoresizingMaskIntoConstraints = false
        return description
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        setupLayout()
    }

    func setData(title: String, shortDescription: String) {
        self.title.text = title
        self.shortDescription.text = shortDescription
    }

    private func setupLayout() {
        addSubview(title)
        addSubview(shortDescription)

        NSLayoutConstraint.activate([
            title.topAnchor.constraint(equalTo: topAnchor, constant: 3),
            title.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            title.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10),
            title.heightAnchor.constraint(equalToConstant: 15),
            shortDescription.topAnchor.constraint(equalTo: title.bottomAnchor, constant: 10),
            shortDescription.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            shortDescription.trailingAnchor.constraint(equalTo: trailingAnchor, constant: 10)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
