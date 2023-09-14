//  Created by илья on 04.08.23.

import UIKit

final class Loader: UIView {
    private let loader: UIView = {
        let loader = UIActivityIndicatorView()
        loader.style = .medium
        loader.startAnimating()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        setupLayout()
        isHidden = true
        backgroundColor = .white
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension Loader {
    private func setupLayout() {
        addSubview(loader)

        NSLayoutConstraint.activate([
            loader.centerXAnchor.constraint(equalTo: centerXAnchor),
            loader.centerYAnchor.constraint(equalTo: centerYAnchor)
        ])
    }
}
