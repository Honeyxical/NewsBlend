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
    func set(source: [Sources])
    func reloadData()
    func showLoader()
    func hideLoader()
    func displayLotty()
}

// View Output
protocol SettingsViewOutputProtocol {
    func viewWillAppear()
}

// Interactor Input
protocol SettingsInteractorInputProtocol {
    func getAllSources()
}

// Interactor Output
protocol SettingsInteractorOutputProtocol: AnyObject {
    func didReceive(sources: [Sources])
    func didReceiveFail()
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
    func getSources() -> [Sources]
    func setSource(source: Source)
}

protocol SettingNetworkServiceProtocol {
    func getEngSources(completion: @escaping (Data) -> Void)
}

protocol MenuViewProtocol {
}
