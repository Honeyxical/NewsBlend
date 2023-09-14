//  Created by илья on 01.08.23.

import UIKit

final class SettingsRouter {
    weak var output: SettingsRouterOutputProtocol?
    weak var viewController: UIViewController?
}

extension SettingsRouter: SettingsRouterInputProtocol {
    func updateSource(newListSources: [SourceModel]){
        let NBSModule = NBSAssembly.build(newSourcesList: newListSources)
        viewController?.navigationController?.pushViewController(NBSModule, animated: true)
    }
}
