//  Created by илья on 04.08.23.

import Foundation
import UIKit

final class ReusableViews {
    static func getLoader(view: UIView) -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView()
        loader.style = .medium
        loader.startAnimating()
        loader.translatesAutoresizingMaskIntoConstraints = false
        return loader
    }
}
