//  Created by илья on 14.09.23.

import UIKit

protocol LottieUnknownErrorDelegate: AnyObject {
    func reloadPage()
}

final class LottieUnknownError: UIView {
    weak var delegate: LottieUnknownErrorDelegate?
    private let lottie: UILabel = {
        let lottie = UILabel()
        lottie.translatesAutoresizingMaskIntoConstraints = false
        lottie.text = "Fail get data"
        lottie.font = UIFont.systemFont(ofSize: 36)
        return lottie
    }()

    private let updateButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("Reload page", for: .normal)
        button.addTarget(nil, action: #selector(updateButtonHandler), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()

    override init(frame: CGRect) {
        super.init(frame: frame)
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .white
        setupLayout()
        isHidden = true
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension LottieUnknownError {
    private func setupLayout() {
        addSubview(lottie)
        addSubview(updateButton)

        NSLayoutConstraint.activate([
            lottie.centerXAnchor.constraint(equalTo: centerXAnchor),
            lottie.centerYAnchor.constraint(equalTo: centerYAnchor),

            updateButton.centerXAnchor.constraint(equalTo: centerXAnchor),
            updateButton.topAnchor.constraint(equalTo: lottie.bottomAnchor, constant: 15)
        ])
    }

    @objc private func updateButtonHandler() {
        delegate?.reloadPage()
    }
}
