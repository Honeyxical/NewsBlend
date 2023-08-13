//  Created by илья on 13.08.23.

import Foundation

class NBSPresentor {
    let interactor: NBSInteractorInputProtocol
    let router: NBSRouterInputProtocol
    let view: NBSViewInputProtocol

    init(interactor: NBSInteractorInputProtocol, router: NBSRouterInputProtocol, view: NBSViewInputProtocol) {
        self.interactor = interactor
        self.router = router
        self.view = view
    }
}

extension NBSPresentor: NBSInteractorOutputProtocol {
    func didReceive() {

    }

    func didReceiveFail() {

    }
}

extension NBSPresentor: NBSViewOutputProtocol {
    func viewDidAppear() {
        
    }
}

extension NBSPresentor: NBSRouterOutputProtocol {
    
}
