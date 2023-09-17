//  Created by илья on 01.08.23.

import Foundation

final class SettingsPresenter {
    weak var view: SettingsViewInputProtocol?
    private let interactor: SettingsInteractorInputProtocol
    private let router: SettingsRouterInputProtocol

    init(view: SettingsViewInputProtocol, interactor: SettingsInteractorInputProtocol, router: SettingsRouterInputProtocol) {
        self.view = view
        self.interactor = interactor
        self.router = router
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

    func viewDidLoad() {
        view?.showLoader()
        interactor.getIntervals()
        interactor.getAllSources()
    }
}

extension SettingsPresenter: SettingsInteractorOutputProtocol {
    func failDeletingSource() {
        view?.displayAlert()
    }

    func didReceive(interval: Int) {
        view?.set(interval: interval)
    }

    func didReceive(sources: [SourceModel]) {
        view?.set(source: sources)
        view?.hideLoader()
    }
}

extension SettingsPresenter: SettingsRouterOutputProtocol {}
