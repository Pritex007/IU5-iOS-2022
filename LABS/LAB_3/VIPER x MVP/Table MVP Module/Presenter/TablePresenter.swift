import UIKit

final class TablePresenter {
    weak var view: TableViewInput!
    weak var moduleOutput: TableModuleOutput!
}

// MARK: - TableViewOutput

extension TablePresenter: TableViewOutput {
    func userDidTapFirstRow() {
        moduleOutput.tableModuleWantsToOpenFuncView()
    }
}

// MARK: - TableModuleInput

extension TablePresenter: TableModuleInput {
    
}
