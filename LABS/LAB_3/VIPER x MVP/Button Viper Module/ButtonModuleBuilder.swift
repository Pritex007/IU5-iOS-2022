import UIKit

final class ButtonModuleBuilder {
    func build(output: ButtonModuleOutput) -> UIViewController {
        let viewController = ButtonViewController()
        let interactor = ButtonInteractor()
        let presenter = ButtonPresenter(interactor: interactor)
        
        viewController.output = presenter
        
        presenter.view = viewController
        presenter.moduleOutput = output
        
        interactor.output = presenter
        
        return viewController
    }
}
