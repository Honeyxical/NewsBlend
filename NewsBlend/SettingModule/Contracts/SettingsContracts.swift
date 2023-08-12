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
    func setFollowedSources(sources: [SourceModel])
}

// Interactor Input
protocol SettingsInteractorInputProtocol {
    func getAllSources()
    func getIntervals()
    func getFollowedSources()
    func setInterval(interval: Int)
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

protocol SettingsDBServiceProtocol{
    func getUpdateInterval() -> Int
    func setUpdateUnterval(interval pos: Int)
    func getSources() -> Data
    func setSource(source: SourceModel)
}

protocol SettingNetworkServiceProtocol {
    func getEngSources(completion: @escaping (Data) -> Void)
}

protocol MenuViewProtocol {
}
