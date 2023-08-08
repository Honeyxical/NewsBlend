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
    func set()
    func reloadData()
    func showLoader()
    func hideLoader()
}

// View Output
protocol SettingsViewOutputProtocol {
}

// Interactor Input
protocol SettingsInteractorInputProtocol {
}

// Interactor Output
protocol SettingsInteractorOutputProtocol: AnyObject {
}

// Router Input
protocol SettingsRouterInputProtocol {
}

// Router Output
protocol SettingsRouterOutputProtocol {
}

protocol SettingsCoreDataServiceProtocol{
    
}

protocol SettingNetworkServiceProtocol {
    func getSources(completion: @escaping (Data) -> Void)
    func getSourcesByCategory(category: String, completion: @escaping (Data) -> Void)
}
