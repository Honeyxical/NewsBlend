//  Created by илья on 01.08.23.

import Foundation

// Module Input
public protocol SettingsModuleInputProtocol {
}

// Module Output
public protocol SettingsModuleOutputProtocol {
}

// View Input
protocol SettingsViewInputProtocol {
    func set(source: [SourceModel])
    func set(interval: Int)
    func reloadData()
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol SettingsViewOutputProtocol {
    func viewWillAppear()
    func setInterval(interval: Int)
    func setFollowedSource(source: SourceModel)
    func deleteFollowedSource(source: SourceModel)
}

// Interactor Input
protocol SettingsInteractorInputProtocol {
    func getAllSources()
    func getIntervals()
    func getFollowedSources() -> [SourceModel]
    func setInterval(interval: Int)
    func setFollowedSource(source: SourceModel)
    func deleteFollowedSource(source: SourceModel)
}

// Interactor Output
protocol SettingsInteractorOutputProtocol: AnyObject {
    func didReceive(sources: [SourceModel])
    func didReceiveFail()
    func didReceive(interval: Int)
}

// Router Input
protocol SettingsRouterInputProtocol {
}

// Router Output
protocol SettingsRouterOutputProtocol {
}

protocol MenuViewProtocol {
}
