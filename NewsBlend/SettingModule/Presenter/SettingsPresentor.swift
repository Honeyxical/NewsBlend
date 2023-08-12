//  Created by илья on 01.08.23.

import Foundation

class SettingsPresentor {
    let view: MenuViewProtocol
    let interactor: SettingsInteractorInputProtocol
    let router: SettingsRouterInputProtocol

    let newsSettingsView: SettingsViewInputProtocol

    init(view: MenuViewProtocol, interactor: SettingsInteractorInputProtocol, router: SettingsRouterInputProtocol, newsSettingsProtocol: SettingsViewInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.newsSettingsView = newsSettingsProtocol
    }
}

extension SettingsPresentor: SettingsViewOutputProtocol {
    func viewWillAppear() {
        newsSettingsView.showLoader()
        interactor.getAllSources()
    }
}

extension SettingsPresentor: SettingsInteractorOutputProtocol {
    func didReceive(sources: [Sources]) {
        newsSettingsView.set(source: sources)
        newsSettingsView.hideLoader()
    }

    func didReceiveFail() {
    }

}

extension SettingsPresentor: SettingsRouterOutputProtocol {
}
