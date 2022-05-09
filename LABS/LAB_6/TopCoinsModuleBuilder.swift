import UIKit

final class TopCoinsModuleBuilder {
    
    func build() -> UIViewController {
        let viewController = TopCoinsTableViewController()
        let presenter = TopCoinsViewPresenter()
        
        viewController.output = presenter
        
        presenter.view = viewController
        
        return viewController
    }
}
