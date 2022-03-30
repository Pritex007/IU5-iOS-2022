
import UIKit

final class ButtonPresenter {
    
    weak var view: ButtonViewInput!
    weak var moduleOutput: ButtonModuleOutput!
    
    var interactor: ButtonInteractorInput!
    
    init(interactor: ButtonInteractorInput) {
        self.interactor = interactor
    }
}

// MARK: - ButtonViewOutput

extension ButtonPresenter: ButtonViewOutput {
    func didTapTableViewButton() {
        moduleOutput.buttonWantsToOpenTable()
    }
}

// MARK: - ButtonInteractorOutput

extension ButtonPresenter: ButtonInteractorOutput {
    
}

