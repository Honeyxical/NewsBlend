//  Created by илья on 04.08.23.

import Foundation
import UIKit

final class ReusableViews {
    static func getLoader(view: UIView) -> UIActivityIndicatorView {
        let loader = UIActivityIndicatorView(frame: view.frame)
        loader.style = .medium
        loader.startAnimating()
        return loader
    }
}
