//  Created by илья on 13.08.23.

import Foundation
import UIKit

class NBSView: UIViewController {
    var output: NBSViewOutputProtocol?

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .purple
    }
}

extension NBSView: NBSViewInputProtocol {
    func set(article: ArticleModel) {

    }

    func showLoader() {

    }

    func hideLoader() {

    }

    func displayLotty() {
        
    }
}
