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
    func didReceive(sources: [SourceModel]) {
        view.set(sources: sources)
    }

    func didReceiveFail() {

    }
}

extension NBSPresentor: NBSViewOutputProtocol {
    func viewDidLoad() {
        viewDidAppear()
    }

    func viewDidAppear() {
        interactor.getSources()
    }
}

extension NBSPresentor: NBSRouterOutputProtocol {
    
}
