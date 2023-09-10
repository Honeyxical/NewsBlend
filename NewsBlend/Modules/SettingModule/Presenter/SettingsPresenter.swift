//  Created by илья on 01.08.23.

import Foundation

final class SettingsPresenter {
    weak var view: MenuViewProtocol?
    private let interactor: SettingsInteractorInputProtocol
    private let router: SettingsRouterInputProtocol
    weak var newsSettingsView: SettingsViewInputProtocol?

    init(view: MenuViewProtocol, interactor: SettingsInteractorInputProtocol, router: SettingsRouterInputProtocol, newsSettingsProtocol: SettingsViewInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
        self.newsSettingsView = newsSettingsProtocol
    }
}

extension SettingsPresenter: SettingsViewOutputProtocol {
    func deleteFollowedSource(source: SourceModel) {
        interactor.deleteFollowedSource(source: source)
    }

    func setInterval(interval: UpdateIntervals) {
        interactor.setInterval(interval: interval)
    }

    func setFollowedSource(source: SourceModel) {
        interactor.setFollowedSource(source: source)
    }

    func viewWillAppear() {
        newsSettingsView?.showLoader()
        interactor.getAllSources()
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    func didReceive(interval: Int) {
        newsSettingsView?.set(interval: interval)
    }

    func didReceive(sources: [SourceModel]) {
        interactor.getIntervals()
        newsSettingsView?.set(source: sources)
        newsSettingsView?.hideLoader()
    }
}

extension SettingsPresenter: SettingsRouterOutputProtocol {}
