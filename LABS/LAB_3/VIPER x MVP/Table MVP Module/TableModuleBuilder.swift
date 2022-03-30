import UIKit

final class TableModuleBuilder {
    
    func build(output: TableModuleOutput) -> UIViewController {
        let viewController = MVPTableViewController()
        let presenter = TablePresenter()
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.moduleOutput = output
        
        return viewController
    }
}
